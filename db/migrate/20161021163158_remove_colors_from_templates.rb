class RemoveColorsFromTemplates < ActiveRecord::Migration[5.0]
  def change
    remove_column :templates, :colors, :string, array: true, default: []
  end
end
