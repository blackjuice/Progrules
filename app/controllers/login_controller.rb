# -*- coding: utf-8 -*-
require 'digest' #hash

class LoginController < ApplicationController
  def index #pagina principal
    #trivial
    #adicionar código para checar :session se já estiver logado
  end

  def new
    #cadastro de professor/admin
  end

  def post
    name = params[:name]
    pass = params[:pass]
    sha256 = Digest::SHA256.new
    pass = sha256.hexdigest pass
    status = User.where(name: name).first

    if (status.nil?)
      redirect_to "http://www.duckduckgo.com"
    elsif (status.pass_hash == pass)
      redirect_to "http://www.google.com.br"
    else
      redirect_to "http://www.bing.com"
    end
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
    redirect_to "/"
  end
end


