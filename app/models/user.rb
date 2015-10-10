# -*- coding: utf-8 -*-
require 'digest' #funcao de hash

class User < ActiveRecord::Base
  attr_accessible :name, :pass_hash, :position
  belongs_to :aluno
  #nome, hash de senha, tipo (admin/aluno)
end
