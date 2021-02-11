class RemoveDrawingIdFromPrizes < ActiveRecord::Migration[5.0]
  def change
    remove_column :prizes, :drawing_id, :integer
  end
end
