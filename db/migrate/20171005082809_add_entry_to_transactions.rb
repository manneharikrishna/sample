class AddEntryToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :entry, foreign_key: true
  end
end
