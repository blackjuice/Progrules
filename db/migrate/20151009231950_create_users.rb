class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :pass_hash
      t.string :position
      t.timestamps
    end
    add_index :users, :name, :unique => true
  end
end
