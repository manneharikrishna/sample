class AddMinPaybackRatioToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :min_payback_ratio, :integer
  end
end
