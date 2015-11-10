# -*- coding: utf-8 -*-
class PreferenciaController < ApplicationController
  def index
    unless session[:position] == "Aluno"
      redirect_to root_path
    end
    aluno = Aluno.where(name: session[:name]).first
    @list = Preferencia.where(preferente_id: aluno.id)
    @edit = @list.size > 0
  end

  def show
    @preferencia = Preferencia.all()
  end

  def new
    unless session[:position] == "Aluno"
      redirect_to root_path
    end
    @possible_names = Array.new()
    @possible_names.push('')
    @possible = Aluno.where(Aluno.arel_table[:name].not_eq(session[:name]))
    @possible.each do |aluno|
      @possible_names.push(aluno.name)
    end
  end

  def create
    if (received = params[:preferencia])
      aluno = Aluno.where(name: session[:name]).first
      [1, 2, 3].each do |i| #TO-DO usar js para fazer arbitrariamente grande - parte 3 segundo Kon
        #Checa se é preferencia
        if (!received['preferencia' + i.to_s].blank?)

          #Ve se já existe preferencia dessa ordem (ordem = 1)
          test = Preferencia.where(ordem: i, preferente_id: aluno.id)
          unless test.first.nil?
            test.first.destroy
          end

          #encontra id do preferido
          search = Aluno.where(name: received['preferencia' + i.to_s]).first

          #Cria nova preferencia
          prefs = Preferencia.new()
          prefs.ordem = i
          prefs.preferente_id = aluno.id
          prefs.preferido_id = search.id
          prefs.save
        end
      end
    end
    redirect_to root_path
  end
end
