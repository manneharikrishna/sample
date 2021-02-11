class RegisterPlayerInAccountingJob < RetryableJob
  def perform(player)
    RegisterPlayerInAccounting.new(player).call
  end
end
