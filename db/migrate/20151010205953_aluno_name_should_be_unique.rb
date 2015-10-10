class AlunoNameShouldBeUnique < ActiveRecord::Migration
  def change
    add_index :alunos, :name, :unique => true
  end
end
