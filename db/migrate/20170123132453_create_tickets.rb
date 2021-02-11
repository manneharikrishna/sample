class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.belongs_to :lottery, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :photo, foreign_key: true

      t.timestamps
    end
  end
end
