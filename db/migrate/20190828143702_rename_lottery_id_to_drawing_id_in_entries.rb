class RenameLotteryIdToDrawingIdInEntries < ActiveRecord::Migration[5.0]
  def change
    rename_column :entries, :lottery_id, :drawing_id
  end
end
