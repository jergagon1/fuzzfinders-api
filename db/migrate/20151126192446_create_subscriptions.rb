class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :report, index: true, foreign_key: true

      t.timestamps null: false

      t.index [:user_id, :report_id], unique: true
    end
  end
end
