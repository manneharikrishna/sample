class Consultancy::SessionSerializer < ActiveModel::Serializer
  attribute :token
  attribute :currency

  has_one :consultant

  def consultant
    object.user
  end
end
