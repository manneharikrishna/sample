class CreateWithdrawal
  delegate :bank_account_number, to: :@player

  def initialize(player, amount)
    @player = player
    @amount = amount
  end

  def call
    create_withdrawal.tap do |withdrawal|
      send_bank_transfer_email(withdrawal)
      schedule_wallet_balance_tracking
    end
  end

  private

  attr_reader :player
  attr_reader :amount

  def create_withdrawal
    Withdrawal.create! do |withdrawal|
      withdrawal.player = player
      withdrawal.bank_account_number = bank_account_number
      withdrawal.amount = -amount
    end
  end

  def send_bank_transfer_email(withdrawal)
    WithdrawalMailer.bank_transfer(player, withdrawal).deliver_later(wait: 10.minutes)
  end

  def schedule_wallet_balance_tracking
    TrackWalletBalanceJob.perform_later(player, wallet_balance)
  end

  def wallet_balance
    CalculateBalance.new(@player).call
  end
end
