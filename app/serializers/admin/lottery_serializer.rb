class Admin::LotterySerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :type
  attribute :status
  attribute :headline
  attribute :description
  attribute :starts_at
  attribute :ends_at
  attribute :tickets_count
  attribute :ticket_price
  attribute :payback_ratio
  attribute :cover_url
  attribute :repeat_every

  has_one :license

  has_many :prizes

  def cover_url
    object.cover.url
  end
end
