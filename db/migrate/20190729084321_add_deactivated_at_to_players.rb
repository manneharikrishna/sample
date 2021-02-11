class AddDeactivatedAtToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :deactivated_at, :datetime
  end
end
