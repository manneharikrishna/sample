class ChangeNninToSsnInPlayers < ActiveRecord::Migration[5.0]
  def change
    rename_column :players, :nnin, :ssn
  end
end
