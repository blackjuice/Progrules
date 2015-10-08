# -*- coding: utf-8 -*-
require 'digest' #funcao de hash

class User < ActiveRecord::Base
  attr_accessible :name, :pass_hash, :type
  #nome, hash de senha, tipo (admin/aluno)

  def self.login_try(username, pass)
    begin
      user = User.where(name: username).take
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Não existe esse usuário"
      return false
    end

    sha256 = Digest::SHA256.new #hash utilizado: SHA256
    pass = sha256.digest pass

    if (user.pass_hash == pass)
      return true
    else
      flash[:notice] = "Senha incorreta"
      return false
    end
  end
end
