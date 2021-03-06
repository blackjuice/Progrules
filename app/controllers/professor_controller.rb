# -*- coding: utf-8 -*-
require 'csv' #abrir arquivos csv
require 'csv_helper.rb'
require 'matrix'

class ProfessorController < ApplicationController
  include CsvHelper

  def index
   unless (session[:position] == "Admin")
     redirect_to root_path
   end
  end

  def excel
    unless (session[:position] == "Admin")
      redirect_to root_path
    end
  end

  def gerador
    unless (session[:position] == "Admin")
      redirect_to root_path
    end
    #Avisa quais alunos n tem preferencias
    @text = ""
    @alunos = Aluno.all()
    @alunos.each do |aluno|
      if aluno.preferencias.empty?
        @text += "<p>" + aluno.name + "</p>"
      end
    end
  end

  def results
    unless (session[:position] == "Admin")
      redirect_to root_path
    end
    @text = ""
    sex_bonus = params["gerador"]["sexo"].to_f
    class_bonus = params["gerador"]["classe"].to_f
    going = Hash.new() #Traduz aluno_id para [0..n de alunos] 
    coming = Hash.new() #Traduz [0..n de alunos] para aluno_id
    test = Aluno.all()
    i = 0
    test.each do |aluno|
      going[aluno.id] = i
      coming[i] = aluno.id
      i = i + 1
    end
    problem = Matrix.build(test.count, test.count) { |row, col|
      if (row == col)
        0.0
      else
        prefs_value = 0.0
        aluno = Aluno.find(coming[row])
        outro = Aluno.find(coming[col])
        #Checa se aluno tem preferencia
        aluno.preferencias.each do |prefs|
          if prefs.preferente_id == outro.id
            prefs_value += prefs.ordem.to_f
          end
        end
        #Checa se outro tem preferencia
        outro.preferencias.each do |prefs|
          if prefs.preferente_id == aluno.id
            prefs_value += prefs.ordem.to_f
          end
        end
        prefs_value = prefs_value / 2 #media
        
        #Checa se tem bonus de sexo
        if (aluno.sexo != outro.sexo)
          prefs_value += sex_bonus
        end
        #Checa se tem bonus de classe
        if (aluno.classe != outro.classe)
          prefs_value += class_bonus
        end
        prefs_value
      end
    }
    #Escreve matriz
    writer = File.new("mymatrix", "w+")
    writer.puts(test.count)
    for i in 0..test.count 
      for j in 0..test.count
        writer.write(problem[i, j])
        writer.write(" ")
      end
      writer.write("\n")
    end
    writer.close

    #Executa script em C
    system("./main < mymatrix")
    
    #Le resposta e mostra ao usuario
    numlines = 1
    reader = File.new("results.txt", "r")
    while (line = reader.gets)
      @text += "<h2>Grupo <b>#{numlines}</b></h2>"
      line.split(",").each do |alunoid| 
        ref = Aluno.find(coming[alunoid.to_i])
        @text += "<p>" + ref.name + "</p>"
      end
      numlines += 1
    end
  end
              
  def upload 
    preferencias = params[:prefs] 
    @text = "" #texto html de resposta
    if (params[:file])
      condition = testCSV(params[:file].path, preferencias)
      if (condition[:status] == 0 || condition[:status] == 1) #sucesso, sucesso com avisos
        @text += "<p>Inseriu com sucesso!</p>"
        @text += condition[:text]
        num_row = 1
        CSV.foreach(params[:file].path) do |row|
          aluno_class = row[0]
          aluno_class.strip!
          aluno_name = row[1]
          aluno_name.strip!
          aluno_sex = row[2]
          aluno_sex.strip!
          test = Aluno.insere_aluno(aluno_class, aluno_name, aluno_sex)
          unless (test[:status])
            @text += "<p>Erro @ linha #{num_row}: " + test[:text] + "</p>" 
          end
          num_row += 1
        end
        if (preferencias && condition[:status] == 0)
          #inserçao de preferencias so acontece se esta tudo, TUDO bem
          CSV.foreach(params[:file].path) do |row|
            aluno_name = row[1]
            aluno_name.strip!
            preferente = Aluno.where(name: aluno_name).first!
            (3..(row.count - 1)).each { |i|
              unless row[i].blank?
                preferido_name = row[i]
                preferido_name.strip!
                ordem = 1 + (i - 3)
                #Ve se ja existe preferencia dessa ordem
                test = Preferencia.where(ordem: ordem, preferente_id: preferente.id)

                unless test.first.nil?
                  test.first.destroy
                end

                preferido = Aluno.where(name: preferido_name).first!
                prefs = Preferencia.new()
                prefs.ordem = ordem
                prefs.preferente_id = preferente.id
                prefs.preferido_id = preferido.id
                prefs.save!
              end
            }
          end
        end
      else
        @text += "<p>Erro: " + condition[:text] + "</p>"
      end
    else
      @text = "<p>Sem arquivo</p>"
    end 
  end
end
