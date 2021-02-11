class AddEntryToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :entry, foreign_key: true
  end
end
