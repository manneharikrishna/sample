class AddImageAspectRatioToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :image_aspect_ratio, :string
  end
end
