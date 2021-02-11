class RenameLabelToDescription < ActiveRecord::Migration[5.0]
  def change
    rename_column :prizes, :label, :description
  end
end
