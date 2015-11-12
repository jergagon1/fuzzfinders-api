class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :image

      t.timestamps null: false
    end
  end
end
