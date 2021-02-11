class AddBankAccountNumberToPlayers< ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bank_account_number, :string
  end
end
