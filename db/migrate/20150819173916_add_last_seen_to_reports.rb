class AddLastSeenToReports < ActiveRecord::Migration
  def up
    add_column :reports, :last_seen, :datetime
  end
  def down
    remove_column :reports, :last_seen, :datetime
  end
end
