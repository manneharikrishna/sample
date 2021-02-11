class TransactionSerializer < ActiveModel::Serializer
  attribute :type
  attribute :amount
  attribute :created_at
  attribute :status

  belongs_to :entry

  def root
    'transaction'
  end

  def type
    object.type.downcase
  end
end
