class Admin::WinningSerializer < ActiveModel::Serializer
  attribute :id
  attribute :created_at

  belongs_to :ticket

  class TicketSerializer < ActiveModel::Serializer
    attribute :id

    belongs_to :entry

    class EntrySerializer < ActiveModel::Serializer
      attribute :id

      belongs_to :player
      belongs_to :photo
    end
  end
end
