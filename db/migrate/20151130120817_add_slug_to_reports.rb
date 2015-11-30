class AddSlugToReports < ActiveRecord::Migration
  def change
    add_column :reports, :slug, :string

    add_index :reports, :slug, unique: true
  end
end
