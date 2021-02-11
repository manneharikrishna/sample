class CalculateTotalTurnOver
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    sold_tickets_count * ticket_price
  end

  private

  attr_reader :drawing

  def sold_tickets_count
    Admin::SoldTicketsCountQuery.new(drawing).call
  end

  def ticket_price
    drawing.lottery.ticket_price || 0.to_d
  end
end
