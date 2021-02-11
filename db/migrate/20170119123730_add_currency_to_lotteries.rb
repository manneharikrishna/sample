class AddCurrencyToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :currency, :string
  end
end
