class Admin::EntrySerializer < ActiveModel::Serializer
  attribute :id
  attribute :status

  belongs_to :player
  belongs_to :photo
end
