class AddPrizeToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :prize, foreign_key: true
  end
end
