class RemoveTypeFromLotteries < ActiveRecord::Migration[5.0]
  def change
    remove_column :lotteries, :type, :string
  end
end
