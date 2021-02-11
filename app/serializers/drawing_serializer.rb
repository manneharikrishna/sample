class DrawingSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :type
  attribute :headline
  attribute :description
  attribute :ends_at
  attribute :tickets_count
  attribute :ticket_price
  attribute :currency
  attribute :cover_url

  has_many :prizes

  def name
    object.lottery.name
  end

  def headline
    object.lottery.headline
  end

  def description
    object.lottery.description
  end

  def tickets_count
    object.lottery.tickets_count
  end

  def ticket_price
    object.lottery.ticket_price
  end

  def type
    object.lottery.type
  end

  def currency
    CURRENCY
  end

  def cover_url
    object.lottery.cover.url
  end
end
