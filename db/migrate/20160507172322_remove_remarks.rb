class RemoveRemarks < ActiveRecord::Migration
  def up
      remove_index :remarks, :article_id
      remove_index :remarks, :user_id
      remove_foreign_key :remarks, :users
      drop_table :remarks
  end

  def down
    create_table :remarks do |t|
      t.text :content
      t.belongs_to :article, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
