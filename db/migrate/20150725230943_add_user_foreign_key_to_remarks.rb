class AddUserForeignKeyToRemarks < ActiveRecord::Migration
  def change
    add_foreign_key :remarks, :users
  end
end
