# -*- coding: utf-8 -*-
require 'securerandom' #senha aleatória
require 'digest' #hash

class AlunoController < ApplicationController
  #Inserir novo aluno
  def index
    unless session[:position] == "Admin"
      redirect_to root_path
    end
   @alunos = Aluno.order("classe, name").all()
  end

  def new
    unless session[:position] == "Admin"
      redirect_to root_path
    end
    @classes = Aluno.classes
    @sexos = Aluno.sexos
  end

  def create
    received = params[:aluno]
    if !(received.nil? or received['nome'].blank?)
      result = Aluno.insere_aluno(received['classe'], received['nome'], received['sexo'])
      if result[:status]
        flash[:notice] = "Aluno inserido com sucesso"
      else
        flash[:notice] = result[:text]
      end
    else
      flash[:notice] = "Não recebi dados suficientes"
    end
    redirect_to '/professor'
  end

  def edit
    @aluno = Aluno.find params[:id]
    @classes = Aluno.classes
    @sexos = Aluno.sexos
  end

  def update
    aluno = Aluno.find params[:id]
    received = params[:aluno]
    aluno.name = received['nome']
    aluno.classe = received['classe']
    aluno.sexo = received['sexo']
    aluno.save
    redirect_to '/alunos'
  end
    
  def destroy
    aluno = Aluno.find params[:id]
    aluno.user.destroy
    aluno.destroy
    redirect_to '/alunos'
  end

end
