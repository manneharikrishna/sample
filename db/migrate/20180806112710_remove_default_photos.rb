class RemoveDefaultPhotos < ActiveRecord::Migration[5.0]
  def change
    drop_table :default_photos do |t|
      t.belongs_to :presentation, foreign_key: true
      t.string :image
      t.integer :slot_number, index: true

      t.timestamps
    end
  end
end
