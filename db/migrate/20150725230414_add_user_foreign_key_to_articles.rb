class AddUserForeignKeyToArticles < ActiveRecord::Migration
  def change
    add_foreign_key :articles, :users
  end
end