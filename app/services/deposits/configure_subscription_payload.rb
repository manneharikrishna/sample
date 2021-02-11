class Deposits::ConfigureSubscriptionPayload < Deposits::ConfigurePayload
  def call(deposit)
    Nets::PayloadConfigurator::RegistrationRecurring.new(payload(deposit))
  end

  private

  def payload(deposit)
    {
      language: language,
      redirect_url: redirect_url(deposit),
      order_number: deposit.id,
      amount: amount,
      recurring_type: 'R',
      recurring_frequency: 0,
      recurring_expiry_date: expiry_date
    }
  end

  def expiry_date
    2.years.from_now.strftime('%Y%m%d')
  end
end
