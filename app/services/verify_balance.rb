class VerifyBalance
  def initialize(player, amount)
    @player = player
    @amount = amount.to_d
  end

  def call
    if amount > balance
      raise ResponseError, :payment_required
    end
  end

  private

  attr_reader :player
  attr_reader :amount

  def balance
    CalculateBalance.new(player).call
  end
end
