# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :name, :pass_hash, :position
  belongs_to :aluno
  #nome, hash de senha, tipo (admin/aluno)
end
