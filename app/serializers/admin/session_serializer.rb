class Admin::SessionSerializer < ActiveModel::Serializer
  attribute :token
  attribute :currency

  has_one :operator

  def operator
    object.user
  end
end
