class RemoveSubmittedAtFromEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :submitted_at, :datetime
  end
end
