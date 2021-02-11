class AddLeadToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_column :lotteries, :lead, :string
  end
end
