class CreateAutomaticWithdrawal
  delegate :bank_account_number, to: :@player
  delegate :balance_limit, to: Limits

  def initialize(player, prize)
    @player = player
    @prize = prize
  end

  def call
    return unless balance_limit_exceeded?

    if bank_account_number.present?
      create_withdrawal
    else
      send_missing_bank_account_number_email
    end
  end

  private

  attr_reader :player
  attr_reader :prize

  def balance_limit_exceeded?
    balance > balance_limit
  end

  def balance
    @balance ||= CalculateBalance.new(player).call
  end

  def create_withdrawal
    CreateWithdrawal.new(player, prize.value).call
  end

  def send_missing_bank_account_number_email
    WithdrawalMailer.missing_bank_account_number(player).deliver_later
  end
end
