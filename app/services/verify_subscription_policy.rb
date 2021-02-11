class VerifySubscriptionPolicy
  delegate :balance_limit, to: Limits

  def initialize(player, amount)
    @player = player
    @amount = amount
  end

  def call
    player_not_suspended? && loss_limits_not_exceeded? && balance_not_exceeded?
  end

  private

  attr_reader :player
  attr_reader :amount
  attr_reader :limits

  def player_not_suspended?
    !player.suspended?
  end

  def loss_limits_not_exceeded?
    !limits.weekly_loss_limit_exceeded? && !limits.daily_loss_limit_exceeded?
  end

  def limits
    @limits ||= VerifyLossLimits.new(player, amount)
  end

  def balance_not_exceeded?
    amount <= max_amount
  end

  def max_amount
    balance_limit - balance
  end

  def balance
    CalculateBalance.new(player).call
  end
end
