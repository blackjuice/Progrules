# -*- coding: utf-8 -*-
require 'securerandom' #senha aleatória
require 'digest' #hash

class AlunoController < ApplicationController
  #Inserir novo aluno
  #TO-DO: achar um jeito inteligente de impedir não logados de entrarem em lugares secretos
  def new
    unless session[:position] == "Admin"
      redirect_to "/"
    end
  end

  def create
    received = params[:aluno]
    if !(received.nil? or received['nome'].blank?)
      begin
        #Começa a criar aluno
        aluno = Aluno.new()
        aluno.name = received['nome']
        aluno.classe = received['classe']
        aluno.sexo = received['sexo']

        #Senha aleatória a ser entregue fisicamente
        random_pass = SecureRandom.hex(4)
        aluno.rand_pass = random_pass

        #Cria o usuário do aluno
        sha256 = Digest::SHA256.new
        user = User.new()
        user.name = received['nome']
        user.pass_hash = sha256.hexdigest random_pass
        user.position = "Aluno"
        user.save

        #Faz associação
        aluno.user = user
        aluno.save
      rescue ActiveRecord::RecordNotUnique
        flash[:notice] = "Já existe aluno ou usuário com esse nome"
        flag = true
      end
      if !flag
        flash[:notice] = "Aluno inserido com sucesso"
      end
    else
      flash[:notice] = "Não recebi dados suficientes"
    end
    redirect_to '/professor'
  end
end
