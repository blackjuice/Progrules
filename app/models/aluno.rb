# -*- coding: utf-8 -*-
require 'securerandom' #senha random
require 'digest' #hash
class Aluno < ActiveRecord::Base
  attr_accessible :name, :rand_pass, :classe, :sexo
  has_one :user
  has_many :preferencias
  has_many :alunos, through: :preferencias

  def self.classes
    return ["A", "B", "C", "D"]
  end
  
  def self.sexos
    return ["M", "F"]
  end

  def self.insere_aluno(classe, name, sexo)
    result = Hash.new()
    #result[:status] = sucesso/falha
    #result[:text] = texto de falha
    begin
      #Começa a criar aluno
      temp = Aluno.new()
      temp.classe = classe
      temp.name = name
      temp.sexo = sexo

      #Senha aleatoria a ser entregue fisicamente
      random_pass = SecureRandom.hex(4)
      temp.rand_pass = random_pass

      #Cria o usuario do aluno
      sha256 = Digest::SHA256.new
      user = User.new()
      user.name = name
      user.pass_hash = sha256.hexdigest random_pass
      user.position = "Aluno"
      user.save!

      #Faz associaçao
      temp.user = user
      temp.save!
    rescue ActiveRecord::RecordNotUnique
      user.destroy
      aluno.destroy
      result[:status] = false
      result[:text] = "Ja existe usuario ou aluno com nome #{name}"
      return result
    rescue ActiveRecord::StatementInvalid => e
      user.destroy
      temp.destroy
      result[:status] = false
      if (e.message[0...28] == "SQLite3::ConstraintException")
        result[:text] = "Ja existe usuario ou aluno com nome #{name}"
      else
        result[:text] = e.message
      end
      return result
    end
    result[:status] = true
    return result
  end
end
