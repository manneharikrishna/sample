class AddPlayerToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :player, foreign_key: true
  end
end
