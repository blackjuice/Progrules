class Preferencia < ActiveRecord::Base
  self.table_name = "preferencias" #weird shit, plural parou de funcionar pra essa table
  attr_accessible :ordem
  belongs_to :preferido, class_name: "Aluno"
  belongs_to :preferente, class_name: "Aluno"
end
