class RenameWinningTicketIdToTicketIdInWinnings < ActiveRecord::Migration[5.0]
  def change
    rename_column :winnings, :winning_ticket_id, :ticket_id
  end
end
