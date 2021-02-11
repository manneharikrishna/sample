class RemoveCurrencyFromLotteries < ActiveRecord::Migration[5.0]
  def change
    remove_column :lotteries, :currency, :string
  end
end
