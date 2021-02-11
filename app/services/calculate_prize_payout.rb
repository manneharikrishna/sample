class CalculatePrizePayout
  def initialize(prize)
    @prize = prize
  end

  def call
    (prize_payout || 0).to_d
  end

  private

  attr_reader :prize

  def prize_payout
    Admin::PrizePayoutQuery.new(prize).call
  end
end
