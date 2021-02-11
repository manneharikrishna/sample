class DepositSerializer < ActiveModel::Serializer
  attribute :id
  attribute :amount
  attribute :status
  attribute :redirect_url
end
