class RenamePaybackRateToPaybackRatio < ActiveRecord::Migration[5.0]
  def change
    rename_column :lotteries, :payback_rate, :payback_ratio
  end
end
