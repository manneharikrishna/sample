class RenameDrawingsToWinnings < ActiveRecord::Migration[5.0]
  def change
    rename_table :drawings, :winnings
  end
end
