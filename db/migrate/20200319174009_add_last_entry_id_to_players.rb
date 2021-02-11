class AddLastEntryIdToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_reference :players, :last_entry, references: :entries, index: true
    add_foreign_key :players, :entries, column: :last_entry_id
  end
end
