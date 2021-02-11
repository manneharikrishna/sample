class AddIsPepToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :is_pep, :boolean, default: false
  end
end
