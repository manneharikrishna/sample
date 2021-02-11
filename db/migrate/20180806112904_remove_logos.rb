class RemoveLogos < ActiveRecord::Migration[5.0]
  def change
    drop_table :logos do |t|
      t.belongs_to :presentation, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
