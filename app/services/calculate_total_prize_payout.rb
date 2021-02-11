class CalculateTotalPrizePayout
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    (total_prize_payout || 0).to_d
  end

  private

  attr_reader :drawing

  def total_prize_payout
    Admin::TotalPrizePayoutQuery.new(drawing).call
  end
end
