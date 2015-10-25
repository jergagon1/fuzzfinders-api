class AddImgUrlToComments < ActiveRecord::Migration
  def up
    add_column :comments, :img_url, :string
  end
  def down
    remove_column :comments, :img_url, :string
  end
end
