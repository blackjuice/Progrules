class Aluno < ActiveRecord::Base
  attr_accessible :name, :rand_pass, :classe, :sexo
  has_one :user
  has_many :escolhas, class_name: "Preferencia"
  has_many :alunos, through: :preferencias
end
