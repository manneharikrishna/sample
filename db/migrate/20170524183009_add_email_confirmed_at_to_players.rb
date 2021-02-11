class AddEmailConfirmedAtToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :email_confirmed_at, :datetime
  end
end
