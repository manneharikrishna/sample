class AddLicenseToLottery < ActiveRecord::Migration[5.0]
  def change
    add_reference :lotteries, :license, foreign_key: true
  end
end
