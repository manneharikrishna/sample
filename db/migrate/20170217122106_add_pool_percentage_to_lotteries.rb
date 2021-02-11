class AddPoolPercentageToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :pool_percentage, :integer
  end
end
