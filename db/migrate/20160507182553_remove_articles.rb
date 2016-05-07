class RemoveArticles < ActiveRecord::Migration
  def up
      remove_foreign_key :articles, :users
      drop_table :articles
  end

  def down
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :user

      t.timestamps null: false
    end
  end
end
