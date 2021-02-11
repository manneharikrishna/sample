class DepositQuery
  def initialize(nets_payment_id)
    @nets_payment_id = nets_payment_id
  end

  def call
    Deposit.find_by("data->>'nets_payment_id' = ?", @nets_payment_id)
  end
end
