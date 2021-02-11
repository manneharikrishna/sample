class PhotoSerializer < ActiveModel::Serializer
  attribute :id
  attribute :url
  attribute :thumbnail_url
  attribute :is_default
  attribute :is_played
  attribute :is_visible

  def url
    object.image.url
  end

  def thumbnail_url
    object.image.thumbnail.url
  end

  def is_default
    object.default?
  end

  def is_played
    object.played?
  end

  def is_visible
    object.visible
  end
end
