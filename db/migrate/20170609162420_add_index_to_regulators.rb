class AddIndexToRegulators < ActiveRecord::Migration[5.0]
  def change
    add_index :regulators, :email, unique: true
  end
end
