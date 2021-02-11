class CalculateGrossGamingRevenue
  def initialize(drawing, total_turn_over)
    @drawing = drawing
    @total_turn_over = total_turn_over.to_d
  end

  def call
    total_turn_over - total_prize_payout
  end

  private

  attr_reader :drawing
  attr_reader :total_turn_over

  def total_prize_payout
    CalculateTotalPrizePayout.new(drawing).call
  end
end
