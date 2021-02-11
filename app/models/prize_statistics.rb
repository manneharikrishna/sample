class PrizeStatistics
  include ActiveModel::Serialization

  delegate :name, to: :@prize

  def initialize(prize, total_turn_over)
    @prize = prize
    @total_turn_over = total_turn_over
  end

  def prize_payout
    @prize_payout ||= CalculatePrizePayout.new(@prize).call
  end

  def prize_payout_ratio
    CalculatePrizePayoutRatio.new(prize_payout, @total_turn_over).call
  end
end
