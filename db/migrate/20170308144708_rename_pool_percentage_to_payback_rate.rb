class RenamePoolPercentageToPaybackRate < ActiveRecord::Migration[5.0]
  def change
    rename_column :lotteries, :pool_percentage, :payback_rate
  end
end
