class CreateDefaultPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :default_photos do |t|
      t.belongs_to :presentation, foreign_key: true
      t.string :image
      t.integer :slot_number

      t.timestamps
    end
  end
end
