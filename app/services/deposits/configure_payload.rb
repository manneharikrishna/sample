class Deposits::ConfigurePayload
  def initialize(player, params)
    @player = player
    @params = params
  end

  def call(deposit)
    Nets::PayloadConfigurator::Registration.new(payload(deposit))
  end

  def amount
    @params[:amount].to_i * 100
  end

  private

  def payload(deposit)
    {
      language: language,
      redirect_url: redirect_url(deposit),
      order_number: deposit.id,
      amount: amount
    }
  end

  def language
    @player.language.to_sym || I18n.default_locale
  end

  def redirect_url(deposit)
    MergeUrlParameters.new(@params[:redirect_url], deposit_id: deposit.id).call
  end
end
