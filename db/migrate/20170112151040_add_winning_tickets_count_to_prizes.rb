class AddWinningTicketsCountToPrizes < ActiveRecord::Migration[5.0]
  def change
    add_column :prizes, :winning_tickets_count, :integer
  end
end
