class RevenueStatistics
  include ActiveModel::Serialization

  def initialize(drawing)
    @drawing = drawing
  end

  def total_turn_over
    @total_turn_over ||= CalculateTotalTurnOver.new(@drawing).call
  end

  def gross_gaming_revenue
    CalculateGrossGamingRevenue.new(@drawing, total_turn_over).call
  end
end
