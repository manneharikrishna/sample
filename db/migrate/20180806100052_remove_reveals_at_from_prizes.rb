class RemoveRevealsAtFromPrizes < ActiveRecord::Migration[5.0]
  def change
    remove_column :prizes, :reveals_at, :datetime
  end
end
