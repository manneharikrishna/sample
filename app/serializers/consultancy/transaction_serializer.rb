class Consultancy::TransactionSerializer < ActiveModel::Serializer
  attribute :id
  attribute :type
  attribute :amount
  attribute :data
  attribute :status
  attribute :subscription_id
  attribute :created_at

  belongs_to :entry

  def root
    'transaction'
  end

  def type
    object.type.downcase
  end
end
