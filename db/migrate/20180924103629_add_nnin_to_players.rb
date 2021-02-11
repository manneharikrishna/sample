class AddNninToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :nnin, :string, unique: true
  end
end
