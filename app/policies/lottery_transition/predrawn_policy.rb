class LotteryTransition::PredrawnPolicy < LotteryTransition::PaidPolicy
  def initialize(lottery)
    @lottery = lottery
  end

  def final?
    super && prizes_present?
  end

  private

  def prizes_present?
    @lottery.prizes.present?
  end
end
