class PrizeImageUploader < ImageUploader
  process convert: :png

  version :thumbnail do
    process resize_to_fill: [380, 380]
  end
end
