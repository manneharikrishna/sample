class VerifyLossLimits
  def initialize(player, amount)
    @player = player
    @amount = amount
  end

  def call
    if weekly_loss_limit_exceeded? || daily_loss_limit_exceeded?
      raise ResponseError.new(:forbidden, :loss_limit_exceeded)
    end
  end

  def weekly_loss_limit_exceeded?
    loss_since(1.week.ago) + amount > weekly_loss_limit
  end

  def daily_loss_limit_exceeded?
    loss_since(1.day.ago) + amount > daily_loss_limit
  end

  private

  attr_reader :player
  attr_reader :amount

  def loss_since(time)
    -transactions.since(time).where(type: [Award, Payment]).sum(:amount)
  end

  def transactions
    player.transactions.completed
  end

  def weekly_loss_limit
    player.weekly_loss_limit || Limits.weekly_loss_limit
  end

  def daily_loss_limit
    player.daily_loss_limit || Limits.daily_loss_limit
  end
end
