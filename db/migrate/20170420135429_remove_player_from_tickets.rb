class RemovePlayerFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_reference :tickets, :player, foreign_key: true
  end
end
