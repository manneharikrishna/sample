class Accountancy::SessionSerializer < ActiveModel::Serializer
  attribute :token
  attribute :currency

  has_one :accountant

  def accountant
    object.user
  end
end
