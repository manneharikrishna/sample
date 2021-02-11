class TicketSerializer < ActiveModel::Serializer
  attribute :id
  attribute :serial_number
  attribute :is_revealed
  attribute :scratch_state

  has_one :photo
  has_one :prize

  def serial_number
    object.serial_number.upcase
  end

  def is_revealed
    object.revealed?
  end

  def photo
    object.entry.photo
  end

  def prize
    object.prize if object.revealed?
  end
end
