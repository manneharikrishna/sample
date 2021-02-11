class RemoveHeadlineFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :headline, :string
  end
end
