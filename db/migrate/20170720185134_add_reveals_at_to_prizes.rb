class AddRevealsAtToPrizes < ActiveRecord::Migration[5.0]
  def change
    add_column :prizes, :reveals_at, :datetime
  end
end
