class CreateTicketAutoreveals < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_autoreveals, id: :integer do |t|
      t.belongs_to :ticket, foreign_key: true, type: :integer
      t.string :ticket_type

      t.timestamps
    end
  end
end
