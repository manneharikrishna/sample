class RegisterTransactionsInAccountingJob < RetryableJob
  def perform(type)
    RegisterTransactionsInAccounting.new(type).call
  end
end
