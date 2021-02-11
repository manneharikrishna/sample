class AddLanguageToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :language, :string
  end
end
