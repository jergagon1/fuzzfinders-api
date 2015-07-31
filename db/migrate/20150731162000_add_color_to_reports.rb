class AddColorToReports < ActiveRecord::Migration
  def up
    add_column :reports, :color, :string
  end
  def down
    remove_column :reports, :color, :string
  end
end
