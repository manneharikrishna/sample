class RenameWinnersCountToQuantity < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :winners_count, :quantity
  end
end
