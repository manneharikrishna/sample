class AddAutorevealedToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :autorevealed, :boolean
  end
end
