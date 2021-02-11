class Nets::RegisterPayment
  def initialize(payload_configurator)
    @payload_configurator = payload_configurator
  end

  def call
    response = register_payment

    if success?(response)
      Nets::Transaction.new(response)
    else
      raise Nets::Error, response
    end
  end

  private

  def register_payment
    Nets::Client.new('/Netaxept/Register.aspx', @payload_configurator.configure).call
  end

  def success?(response)
    response['RegisterResponse'].present?
  end
end
