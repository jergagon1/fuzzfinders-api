class AddDefaultValueToWags < ActiveRecord::Migration
  def change
    change_column :users, :wags, :integer, :default => 0
  end
end
