class ChangeReportsNotesDatatype < ActiveRecord::Migration
  def up
    change_column :reports, :notes, :text
  end
  def down
    change_column :reports, :notes, :string
  end
end
