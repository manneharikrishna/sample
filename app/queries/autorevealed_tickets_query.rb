class AutorevealedTicketsQuery
  def initialize(player, drawing)
    @player = player
    @drawing = drawing
  end

  def call
    drawing_autorevealed_tickets
  end

  def weekly_tickets
    weekly_autorevealed(drawing_autorevealed_tickets)
  end

  def subscription_tickets
    subscription_autorevealed(drawing_autorevealed_tickets)
  end

  private

  def drawing_autorevealed_tickets
    @drawing_autorevealed_tickets ||= filter_by_drawing(revealed_tickets)
  end

  def filter_by_drawing(relation)
    relation.where(drawing: @drawing)
  end

  def revealed_tickets
    @player.tickets.joins(:ticket_autoreveals)
  end

  def weekly_autorevealed(relation)
    relation.where(ticket_autoreveals: { ticket_type: :weekly })
  end

  def subscription_autorevealed(relation)
    relation.where(ticket_autoreveals: { ticket_type: :subscription })
  end
end
