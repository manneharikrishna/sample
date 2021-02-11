class RemovePaybackRatioFromDrawings < ActiveRecord::Migration[5.1]
  def change
    remove_column :drawings, :payback_ratio, :integer
  end
end
