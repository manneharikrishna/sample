class DrawingTicketsQuery
  def initialize(player, drawing)
    @player = player
    @drawing = drawing
  end

  def call
    filter_by_prizes(filter_by_drawing(filter_by_revealed_entry(unrevealed_tickets)))
  end

  private

  def unrevealed_tickets
    @player.tickets.not_revealed.left_joins(:prize)
  end

  def filter_by_drawing(relation)
    relation.where(drawing: @drawing)
  end

  def filter_by_revealed_entry(relation)
    relation.joins(:entry).where.not(entries: { revealed_at: nil })
  end

  def filter_by_prizes(relation)
    relation.where('prize_id IS NULL OR prizes.reveal_type = ?', :drawing_end)
  end
end
