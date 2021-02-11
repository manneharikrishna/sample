class CreateAward
  def initialize(entry, prize)
    @entry = entry
    @prize = prize
  end

  def call
    entry.transaction do
      create_award
      create_automatic_withdrawal

      schedule_wallet_balance_tracking
    end
  end

  private

  attr_reader :entry
  attr_reader :prize

  def create_award
    Award.create! do |award|
      award.entry = entry
      award.player = entry.player
      award.amount = prize.value
    end
  end

  def create_automatic_withdrawal
    CreateAutomaticWithdrawal.new(entry.player, prize).call
  end

  def schedule_wallet_balance_tracking
    TrackWalletBalanceJob.perform_later(entry.player, wallet_balance)
  end

  def wallet_balance
    CalculateBalance.new(entry.player).call
  end
end
