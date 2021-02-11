class AddIpAddressToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :ip_address, :string
  end
end
