class AddSubscrptionIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :subscription, foreign_key: true, type: :integer
  end
end
