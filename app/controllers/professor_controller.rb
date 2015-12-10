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
    @text = `./main < mymatrix`
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
          test = Aluno.insere_aluno(row[0], row[1], row[2])
          unless (test[:status])
            @text += "<p>Erro @ linha #{num_row}: " + test[:text] + "</p>" 
          end
          num_row += 1
        end
        if (preferencias && condition[:status] == 0)
          #inserçao de preferencias so acontece se esta tudo, TUDO bem
          CSV.foreach(params[:file].path) do |row|
            preferente = Aluno.where(name: row[1]).first!
            (3..(row.count - 1)).each { |i|
              unless row[i].blank?
                ordem = 1 + (i - 3)
                #Ve se ja existe preferencia dessa ordem
                test = Preferencia.where(ordem: ordem, preferente_id: preferente.id)

                unless test.first.nil?
                  test.first.destroy
                end

                preferido = Aluno.where(name: row[i]).first!
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
