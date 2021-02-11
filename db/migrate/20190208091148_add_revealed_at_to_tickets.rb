class AddRevealedAtToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :revealed_at, :datetime
  end
end
