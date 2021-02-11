class AddRevealedToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :revealed, :boolean
  end
end
