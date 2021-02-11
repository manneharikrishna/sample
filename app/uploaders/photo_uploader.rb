class PhotoUploader < ImageUploader
  process convert: :jpg

  version :thumbnail do
    process resize_to_fill: [200, 200, :face]
  end
end
