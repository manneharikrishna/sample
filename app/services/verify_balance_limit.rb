class VerifyBalanceLimit
  delegate :balance_limit, to: Limits

  def initialize(amount, player)
    @amount = amount.to_d
    @player = player
  end

  def call
    if amount > max_amount
      raise ResponseError, :forbidden
    end
  end

  private

  attr_reader :amount
  attr_reader :player

  def max_amount
    balance_limit - balance
  end

  def balance
    CalculateBalance.new(player).call
  end
end
