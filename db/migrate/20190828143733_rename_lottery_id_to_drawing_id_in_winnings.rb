class RenameLotteryIdToDrawingIdInWinnings < ActiveRecord::Migration[5.0]
  def change
    rename_column :winnings, :lottery_id, :drawing_id
  end
end
