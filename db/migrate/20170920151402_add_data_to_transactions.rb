class AddDataToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :data, :jsonb, default: {}
  end
end
