class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.text :content
      t.belongs_to :article, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
