class AddColorsToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :colors, :string, array: true, default: []
  end
end
