class CreateDrawings < ActiveRecord::Migration[5.0]
  def change
    create_table :drawings do |t|
      t.belongs_to :lottery, foreign_key: true
      t.integer :winning_ticket_id

      t.timestamps
    end
    add_index :drawings, :winning_ticket_id
  end
end
