class RemoveForeignKeyFromEntries < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :entries, :photos
  end
end
