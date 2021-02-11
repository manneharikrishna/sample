class RenameTemplateFieldsToFields < ActiveRecord::Migration[5.0]
  def change
    rename_table :template_fields, :fields
  end
end
