class Nets::PayloadConfigurator::SubsequentRecurring < Nets::PayloadConfigurator::Registration
  attr_reader :language
  attr_reader :order_number
  attr_reader :amount
  attr_reader :pan_hash
  attr_reader :recurring_type
  attr_reader :service_type

  def initialize(params)
    @auto_auth = true
    @currency_code = config.currency
    @payment_method_action_list = payment_method_action_list.to_json
    @language = language(params)
    @order_number = params[:order_number]
    @amount = params[:amount]
    @pan_hash = params[:pan_hash]
    @recurring_type = params[:recurring_type]
    @service_type = params[:service_type]
  end

  private

  def language(params)
    super
  end
end
