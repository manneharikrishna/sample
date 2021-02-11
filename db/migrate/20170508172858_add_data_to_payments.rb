class AddDataToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :data, :jsonb, default: {}
  end
end
