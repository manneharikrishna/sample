class AddInformationToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :information, :boolean, default: true
  end
end
