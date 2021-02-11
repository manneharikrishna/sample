class RemoveAutorevealedFromTickets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tickets, :autorevealed, :string
  end
end
