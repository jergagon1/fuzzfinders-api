class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :pet_name
      t.string :animal_type
      t.float :lat
      t.float :lng
      t.integer :user_id
      t.string :report_type
      t.string :notes
      t.string :img_url
      t.string :age
      t.string :breed
      t.string :sex
      t.string :size
      t.float :distance

      t.timestamps null: false
    end
  end
end
