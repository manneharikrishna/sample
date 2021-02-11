class EntrySerializer < ActiveModel::Serializer
  attribute :id
  attribute :tickets_count
  attribute :created_at
  attribute :entry_type
  attribute :is_revealed

  belongs_to :drawing
  belongs_to :photo

  has_one :payment

  has_many :tickets

  def is_revealed
    object.revealed?
  end
end
