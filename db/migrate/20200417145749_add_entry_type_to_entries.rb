class AddEntryTypeToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :entry_type, :string
    add_index :entries, :entry_type
  end
end
