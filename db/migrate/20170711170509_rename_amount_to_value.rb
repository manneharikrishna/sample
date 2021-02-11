class RenameAmountToValue < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :amount, :value
  end
end
