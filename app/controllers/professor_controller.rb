# -*- coding: utf-8 -*-
require 'csv' #abrir arquivos csv
require 'csv_helper.rb'

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
