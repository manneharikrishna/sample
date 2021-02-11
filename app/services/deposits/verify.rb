class Deposits::Verify
  delegate :nets_payment_id, to: :@deposit
  delegate :amount, to: :@deposit

  attr_reader :nets_payment

  def initialize(deposit)
    @deposit = deposit
  end

  def call
    payment = nets_payment

    if payment.authorized?
      capture_nets_payment unless payment.captured?(amount)
    else
      update_transaction_status(payment)
      return
    end

    payment = nets_payment

    if payment.captured?(amount)
      update_transaction_status(payment)
      schedule_wallet_balance_tracking
    end
  end

  private

  attr_reader :deposit

  def nets_payment
    Nets::QueryPayment.new(nets_payment_id).call
  end

  def capture_nets_payment
    Nets::CapturePayment.new(nets_payment_id).call
  end

  def update_transaction_status(payment)
    deposit.update!(status: transaction_status(payment))
  end

  def transaction_status(payment)
    if payment.captured?(amount)
      'completed'
    elsif payment.cancelled?
      'cancelled'
    else
      'failed'
    end
  end

  def schedule_wallet_balance_tracking
    TrackWalletBalanceJob.perform_later(deposit.player, wallet_balance)
  end

  def wallet_balance
    CalculateBalance.new(deposit.player).call
  end
end
