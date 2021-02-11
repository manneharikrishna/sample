class AddMaxDurationToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :max_duration, :integer
  end
end
