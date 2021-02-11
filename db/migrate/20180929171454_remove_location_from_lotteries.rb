class RemoveLocationFromLotteries < ActiveRecord::Migration[5.0]
  def change
    remove_column :lotteries, :location, :string
  end
end
