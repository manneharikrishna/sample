class CreateLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :logos do |t|
      t.belongs_to :visualization, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
