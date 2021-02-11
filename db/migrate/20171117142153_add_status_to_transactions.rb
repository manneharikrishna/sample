class AddStatusToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :status, :string, default: 'completed'
  end
end
