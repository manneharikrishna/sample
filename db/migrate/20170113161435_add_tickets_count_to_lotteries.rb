class AddTicketsCountToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :tickets_count, :integer
  end
end
