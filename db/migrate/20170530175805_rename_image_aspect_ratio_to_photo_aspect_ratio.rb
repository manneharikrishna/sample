class RenameImageAspectRatioToPhotoAspectRatio < ActiveRecord::Migration[5.0]
  def change
    rename_column :templates, :image_aspect_ratio, :photo_aspect_ratio
  end
end
