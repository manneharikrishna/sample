class LotteryTransition::PoolPolicy < LotteryTransition::PaidPolicy
  def initialize(lottery)
    @lottery = lottery
  end

  private

  def required_attributes
    super + [:payback_ratio]
  end
end
