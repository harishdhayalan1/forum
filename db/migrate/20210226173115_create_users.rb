class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.index  :email, unique: true
      t.string :crypted_password
      t.string :password_salt
      t.boolean :active

      t.timestamps null: false
    end
  end
end
