class RenameLotteryIdToDrawingIdInTickets < ActiveRecord::Migration[5.0]
  def change
    rename_column :tickets, :lottery_id, :drawing_id
  end
end
