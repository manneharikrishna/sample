class RemoveTemplates < ActiveRecord::Migration[5.0]
  def change
    drop_table :templates do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :logos, default: [], array: true
      t.string :photo_aspect_ratio

      t.timestamps
    end
  end
end
