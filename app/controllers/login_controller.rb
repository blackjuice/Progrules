# -*- coding: utf-8 -*-
require 'digest' #hash

class LoginController < ApplicationController
  def index #pagina principal
    #trivial
    if (session[:position] == "Admin")
      redirect_to "/professor"
    elsif (session[:position] == "Aluno")
      redirect_to "/preferencia"
    end
  end

  def new
    #cadastro de professor/admin
  end

  #login
  def post
    name = params[:name]
    pass = params[:pass]
    sha256 = Digest::SHA256.new
    pass = sha256.hexdigest pass
    status = User.where(name: name).first

    if (status.nil?)
      flash[:notice] = "usuário não encontrado"
    elsif (status.pass_hash == pass)
      session[:name] = status.name
      session[:position] = status.position
    else
      flash[:notice] = "senha incorreta"
    end
    redirect_to root_path
  end

  def create
    if (!(params[:name].blank?) and !(params[:pass].blank?))
      flag = false
      sha256 = Digest::SHA256.new
      begin
        user = User.new
        user.name = params[:name]
        user.pass_hash = sha256.hexdigest params[:pass]
        user.position = "Admin"
        user.save
      rescue ActiveRecord::RecordNotUnique
        flash[:notice] = "Já existe um usuário com esse nome"
        flag = true
      end
      if (!flag)
        flash[:notice] = "Usuário criado com sucesso"
      end
    end
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end


