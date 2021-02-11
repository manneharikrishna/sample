class AddImageToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :image, :string
  end
end
