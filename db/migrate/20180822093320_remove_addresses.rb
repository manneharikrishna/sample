class RemoveAddresses < ActiveRecord::Migration[5.0]
  def change
    drop_table :addresses do |t|
      t.belongs_to :user, foreign_key: true
      t.string :line1
      t.string :line2
      t.string :city
      t.string :zip_code
      t.string :country

      t.timestamps
    end
  end
end
