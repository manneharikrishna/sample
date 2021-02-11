class PayoutStatistics
  include ActiveModel::Serialization

  def initialize(drawing)
    @drawing = drawing
  end

  def total_prize_payout
    @total_prize_payout ||= CalculateTotalPrizePayout.new(@drawing).call
  end

  def total_prize_payout_ratio
    CalculatePrizePayoutRatio.new(total_prize_payout, total_turn_over).call
  end

  def prizes
    @drawing.prizes.map { |p| PrizeStatistics.new(p, total_turn_over) }
  end

  private

  def total_turn_over
    @total_turn_over ||= CalculateTotalTurnOver.new(@drawing).call
  end
end
