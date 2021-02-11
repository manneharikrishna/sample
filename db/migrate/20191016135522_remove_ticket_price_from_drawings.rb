class RemoveTicketPriceFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :ticket_price, :decimal, precision: 12, scale: 2
  end
end
