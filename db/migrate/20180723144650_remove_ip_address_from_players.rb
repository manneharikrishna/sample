class RemoveIpAddressFromPlayers < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :ip_address, :string
  end
end
