class RenameWinningTicketsCountToWinnersCount < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :winning_tickets_count, :winners_count
  end
end
