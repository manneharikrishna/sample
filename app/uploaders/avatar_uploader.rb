class AvatarUploader < ImageUploader
  process convert: :jpg
  process resize_to_fill: [230, 230, :face]

  version :thumbnail do
    process resize_to_fill: [52, 52]
  end
end
