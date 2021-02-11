class AddSubmittedAtToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :submitted_at, :datetime
  end
end
