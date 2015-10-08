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
    status = User.login_try(name, pass)
    if (status)
      redirect_to "http://www.google.com.br"
    else
      redirect_to "http://www.bing.com"
    end
  end

  def create
    sha256 = Digest::SHA256.new
    user = User.new
    user.name = params[:name]
    user.pass = sha256.digest params[:pass]
    user.type = "Admin"
    user.save
    redirect_to root
    flash[:notice] = "Usuário criado com sucesso"
  end
end


