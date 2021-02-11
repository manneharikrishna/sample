class AddRevealedAtToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :revealed_at, :datetime
  end
end
