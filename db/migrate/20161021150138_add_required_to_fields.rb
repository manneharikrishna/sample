class AddRequiredToFields < ActiveRecord::Migration[5.0]
  def change
    add_column :fields, :required, :boolean, default: false
  end
end
