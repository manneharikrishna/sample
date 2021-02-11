class Avatar
  include ActiveModel::Serialization

  def initialize(player)
    @player = player
  end

  def url
    @player.avatar.url
  end

  def thumbnail_url
    @player.avatar.thumbnail.url
  end
end
