class DrawingStatistics
  include ActiveModel::Serialization

  def initialize(drawing)
    @drawing = drawing
  end

  def revenue_statistics
    RevenueStatistics.new(@drawing)
  end

  def tickets_statistics
    TicketsStatistics.new(@drawing)
  end

  def spending_statistics
    SpendingStatistics.new(@drawing)
  end

  def payout_statistics
    PayoutStatistics.new(@drawing)
  end
end
