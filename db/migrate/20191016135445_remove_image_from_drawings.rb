class RemoveImageFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :image, :string
  end
end
