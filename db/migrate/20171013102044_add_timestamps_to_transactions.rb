class AddTimestampsToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :created_at, :datetime, null: false
    add_column :transactions, :updated_at, :datetime, null: false
  end
end
