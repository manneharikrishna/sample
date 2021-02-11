class RemoveTicketsCountFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :tickets_count, :integer
  end
end
