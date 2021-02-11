class PrizeSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :description
  attribute :value
  attribute :quantity
  attribute :reveal_type
  attribute :image_url
  attribute :thumbnail_url

  def image_url
    object.image.url
  end

  def thumbnail_url
    object.image.thumbnail.url
  end
end
