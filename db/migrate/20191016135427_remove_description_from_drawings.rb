class RemoveDescriptionFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :description, :string
  end
end
