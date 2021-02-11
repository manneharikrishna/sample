class CalculatePrizePayoutRatio
  def initialize(prize_payout, total_turn_over)
    @prize_payout = prize_payout.to_d
    @total_turn_over = total_turn_over.to_d
  end

  def call
    return 0.to_d unless total_turn_over.positive?
    prize_payout / total_turn_over * 100
  end

  private

  attr_reader :prize_payout
  attr_reader :total_turn_over
end
