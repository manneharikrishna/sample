class WithdrawalSerializer < ActiveModel::Serializer
  attribute :amount
  attribute :created_at

  def amount
    -object.amount
  end
end
