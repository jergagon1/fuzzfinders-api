class CreateReportTags < ActiveRecord::Migration
  def change
    create_table :report_tags do |t|
      t.integer :tag_id
      t.integer :report_id

      t.timestamps null: false
    end
  end
end