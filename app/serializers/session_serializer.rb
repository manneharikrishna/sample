class SessionSerializer < ActiveModel::Serializer
  attribute :token
  attribute :currency

  has_one :player
  has_many :limits

  def player
    object.user
  end
end
