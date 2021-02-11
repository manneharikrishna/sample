class AddTicketPriceToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :ticket_price, :decimal, precision: 8, scale: 2
  end
end
