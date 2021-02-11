class RemoveUserFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_reference :tickets, :user, foreign_key: true
  end
end
