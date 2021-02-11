class LotteryTransition::SocialPolicy
  def initialize(lottery)
    @lottery = lottery
  end

  def final?
    true
  end
end
