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
end
