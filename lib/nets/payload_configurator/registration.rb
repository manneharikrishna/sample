class Nets::PayloadConfigurator::Registration
  delegate :config, to: Nets
  delegate :payment_methods, to: :config
  delegate :languages, to: :config

  def initialize(params)
    @auto_auth = true
    @currency_code = config.currency
    @payment_method_action_list = payment_method_action_list.to_json
    @language = language(params)
    @redirect_url = params[:redirect_url]
    @order_number = params[:order_number]
    @amount = params[:amount]
  end

  def configure
    instance_values
  end

  private

  def payment_method_action_list
    payment_methods.split(',').map { |pm| { PaymentMethod: pm.strip } }
  end

  def language(params)
    languages[params[:language]]
  end
end
