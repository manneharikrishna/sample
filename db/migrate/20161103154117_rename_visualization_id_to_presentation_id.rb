class RenameVisualizationIdToPresentationId < ActiveRecord::Migration[5.0]
  def change
    rename_column :logos, :visualization_id, :presentation_id
  end
end
