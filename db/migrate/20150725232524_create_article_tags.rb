class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.integer :tag_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
