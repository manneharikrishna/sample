class RenameVisualizationToPresentation < ActiveRecord::Migration[5.0]
  def change
    rename_table :visualizations, :presentations
  end
end
