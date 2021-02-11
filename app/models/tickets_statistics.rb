class TicketsStatistics
  include ActiveModel::Serialization

  def initialize(drawing)
    @drawing = drawing
  end

  def players_count
    @drawing.players.count('DISTINCT players.id')
  end

  def sold_tickets_count
    Admin::SoldTicketsCountQuery.new(@drawing).call
  end

  def winning_tickets_count
    Admin::WinningTicketsCountQuery.new(@drawing).call
  end
end
