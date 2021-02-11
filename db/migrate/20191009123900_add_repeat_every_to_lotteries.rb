class AddRepeatEveryToLotteries < ActiveRecord::Migration[5.1]
  def change
    add_column :lotteries, :repeat_every, :integer
  end
end
