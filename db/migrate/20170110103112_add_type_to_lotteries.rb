class AddTypeToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :type, :string
  end
end
