class Nets::PayloadConfigurator::RegistrationRecurring < Nets::PayloadConfigurator::Registration
  attr_reader :language
  attr_reader :redirect_url
  attr_reader :order_number
  attr_reader :amount
  attr_reader :recurring_type
  attr_reader :recurring_frequency
  attr_reader :recurring_expiry_date

  def initialize(params)
    @auto_auth = true
    @currency_code = config.currency
    @payment_method_action_list = payment_method_action_list.to_json
    @language = language(params)
    @redirect_url = params[:redirect_url]
    @order_number = params[:order_number]
    @amount = params[:amount]
    @recurring_type = params[:recurring_type]
    @recurring_frequency = params[:recurring_frequency]
    @recurring_expiry_date = params[:recurring_expiry_date]
  end

  private

  def language(params)
    super
  end
end
