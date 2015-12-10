class AddCoordsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :lat, :float
    add_column :comments, :lng, :float
  end
end
