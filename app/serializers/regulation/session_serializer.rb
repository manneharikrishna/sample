class Regulation::SessionSerializer < ActiveModel::Serializer
  attribute :token
  attribute :currency
end
