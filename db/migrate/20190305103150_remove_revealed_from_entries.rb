class RemoveRevealedFromEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :revealed, :boolean
  end
end
