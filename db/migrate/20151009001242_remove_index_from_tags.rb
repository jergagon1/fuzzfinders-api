class RemoveIndexFromTags < ActiveRecord::Migration
  def change
    remove_index :tags, :name
  end
end