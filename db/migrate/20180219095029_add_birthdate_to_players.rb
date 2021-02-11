class AddBirthdateToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :birthdate, :date
  end
end
