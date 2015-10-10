class Aluno < ActiveRecord::Base
  attr_accessible :name, :rand_pass, :classe, :sexo
  has_one :user
  has_many :preferencias
  has_many :alunos, through: :preferencias
end
