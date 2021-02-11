class Deposits::ConfigureRecurringPaymentPayload < Deposits::ConfigurePayload
  def call(deposit)
    Nets::PayloadConfigurator::SubsequentRecurring.new(payload(deposit))
  end

  private

  def payload(deposit)
    {
      language: language,
      order_number: deposit.id,
      amount: amount,
      pan_hash: nets_token,
      recurring_type: 'R',
      service_type: 'C'
    }
  end

  def nets_token
    @params[:nets_token]
  end
end
