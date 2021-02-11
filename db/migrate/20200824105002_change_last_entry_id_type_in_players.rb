class ChangeLastEntryIdTypeInPlayers < ActiveRecord::Migration[5.1]
  def up
    change_column :players, :last_entry_id, :integer
  end

  def down
    change_column :players, :last_entry_id, :bigint
  end
end
