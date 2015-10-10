class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      t.string :name
      t.string :rand_pass
      t.string :classe
      t.string :sexo
      t.timestamps
    end

    create_table :users do |t|
      t.belongs_to :aluno, index: true
      t.string :name
      t.string :pass_hash
      t.string :position
      t.timestamps
    end
    add_index :users, :name, :unique => true

    create_table :preferencias do |t|
      t.string :ordem
      t.belongs_to :aluno, foreign_key: "preferido_id"
      t.belongs_to :aluno, foreign_key: "preferente_id"
      t.timestamps
    end
  end
end
