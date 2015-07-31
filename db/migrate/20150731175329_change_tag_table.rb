class ChangeTagTable < ActiveRecord::Migration
  def change
    rename_column :tags, :content, :name
    add_index :tags, :name
  end
end