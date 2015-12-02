class MigrateSlugReports < ActiveRecord::Migration
  def up
    Report.find_each.map &:save
  end
end
