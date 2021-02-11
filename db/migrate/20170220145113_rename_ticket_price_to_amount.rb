class RenameTicketPriceToAmount < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :ticket_price, :amount
  end
end
