class RemoveLicenseeFromLicenses < ActiveRecord::Migration[5.0]
  def change
    remove_reference :licenses, :licensee
  end
end
