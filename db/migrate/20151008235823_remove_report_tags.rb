class RemoveReportTags < ActiveRecord::Migration
  def change
    drop_join_table :reports, :tags, table_name: :report_tags
  end
end
