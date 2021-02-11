class Admin::DrawingSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :type
  attribute :status
  attribute :starts_at
  attribute :ends_at

  has_one :license

  has_many :prizes

  def type
    object.lottery.type
  end

  def license
    object.lottery.license
  end

  def prizes
    object.prizes.order(value: :desc)
  end
end
