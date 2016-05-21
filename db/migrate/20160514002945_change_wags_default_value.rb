class ChangeWagsDefaultValue < ActiveRecord::Migration
  def change
    change_column :users, :wags, :integer, :default => 3
  end
end
