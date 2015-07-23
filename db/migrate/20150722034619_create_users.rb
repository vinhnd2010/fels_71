class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :avatar
      t.string :password_digest
      t.string :remember_digest
      t.integer :role

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
