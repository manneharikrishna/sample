class AddSuspendedUntilToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :suspended_until, :datetime
  end
end
