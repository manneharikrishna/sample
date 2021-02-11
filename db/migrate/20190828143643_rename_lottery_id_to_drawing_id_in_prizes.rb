class RenameLotteryIdToDrawingIdInPrizes < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :lottery_id, :drawing_id
  end
end
