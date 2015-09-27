class ChangeReportSize < ActiveRecord::Migration
  def change
    rename_column :reports, :size, :pet_size
  end
end
