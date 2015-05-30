class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.integer :zipcode
      t.integer :wags

      t.timestamps null: false
    end
  end
end
