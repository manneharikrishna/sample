class AddLossLimitsToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :weekly_loss_limit, :integer
    add_column :players, :daily_loss_limit, :integer
  end
end
