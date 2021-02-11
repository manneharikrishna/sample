class GenerateTickets
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    Ticket.import(values, validate: false)
  end

  private

  attr_reader :drawing

  def values
    [attributes] * drawing.lottery.tickets_count
  end

  def attributes
    { drawing_id: drawing.id }
  end
end
