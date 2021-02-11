class ChangeAmountInPrizes < ActiveRecord::Migration[5.0]
  def change
    change_column :prizes, :amount, :decimal, precision: 12, scale: 2
  end
end
