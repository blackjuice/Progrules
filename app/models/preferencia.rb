class Preferencia < ActiveRecord::Base
  attr_accessible :ordem
  belongs_to :preferido, class_name: "Aluno"
  belongs_to :preferente, class_name: "Aluno"
end
