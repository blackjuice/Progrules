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
    if (params[:file])
      @text = "<p>Temos arquivo</p>"
      condition = testCSV(params[:file].path, preferencias)
      if (condition[:status])
        @text += "<p>Teste com sucesso!</p>"
        num_row = 1
        CSV.foreach(params[:file].path) do |row|
         test = Aluno.insere_aluno(row[0], row[1], row[2])
          unless (test[:status])
            @text += "<p>Erro @ linha #{num_row}: " + test[:text] + "</p>"
          end
          num_row += 1
        end
      else
        @text += "<p>Erro: " + condition[:text] + "</p>"
      end
    else
      @text = "<p>Sem arquivo</p>"
    end 
  end
end
