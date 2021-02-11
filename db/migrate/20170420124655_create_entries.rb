class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.belongs_to :lottery, foreign_key: true
      t.belongs_to :player, foreign_key: true
      t.belongs_to :photo, foreign_key: true
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
