class AddMaxTotalRevenueToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :max_total_revenue, :decimal, precision: 12, scale: 2
  end
end
