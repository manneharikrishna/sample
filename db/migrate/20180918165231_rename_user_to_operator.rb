class RenameUserToOperator < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :operators
  end
end
