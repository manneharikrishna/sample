class AddIndexToLicensees < ActiveRecord::Migration[5.0]
  def change
    remove_index :licensees, :email
    add_index :licensees, :email, unique: true
  end
end
