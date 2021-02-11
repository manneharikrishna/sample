class CreatePayment
  def initialize(entry, amount)
    @entry = entry
    @amount = amount
  end

  def call
    create_payment.tap { schedule_wallet_balance_tracking }
  end

  private

  attr_reader :entry
  attr_reader :amount

  def create_payment
    Payment.create! do |payment|
      payment.entry = entry
      payment.player = entry.player
      payment.amount = -amount
    end
  end

  def schedule_wallet_balance_tracking
    TrackWalletBalanceJob.perform_later(entry.player, wallet_balance)
  end

  def wallet_balance
    CalculateBalance.new(entry.player).call
  end
end
