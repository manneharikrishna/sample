class CreatePrizes < ActiveRecord::Migration[5.0]
  def change
    create_table :prizes do |t|
      t.belongs_to :lottery, foreign_key: true
      t.string :name
      t.string :label
      t.string :image

      t.timestamps
    end
  end
end
