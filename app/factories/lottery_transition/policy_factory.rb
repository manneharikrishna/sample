class LotteryTransition::PolicyFactory
  def initialize(lottery)
    @lottery = lottery
  end

  def create
    policy_class.new(@lottery)
  end

  private

  def policy_class
    self.class.parent.const_get(policy_class_name)
  end

  def policy_class_name
    "#{@lottery.type.classify}Policy"
  end
end
