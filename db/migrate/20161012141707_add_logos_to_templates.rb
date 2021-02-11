class AddLogosToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :logos, :string, array: true, default: []
  end
end
