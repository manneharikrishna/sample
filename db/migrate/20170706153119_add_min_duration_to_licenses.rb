class AddMinDurationToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :min_duration, :integer
  end
end
