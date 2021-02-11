class AddMaxPaybackRatioToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :max_payback_ratio, :integer
  end
end
