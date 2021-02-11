class ChangeTicketPriceInLotteries < ActiveRecord::Migration[5.0]
  def change
    change_column :lotteries, :ticket_price, :decimal, precision: 12, scale: 2
  end
end
