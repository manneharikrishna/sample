class Nets::QueryPayment
  def initialize(transaction_id)
    @transaction_id = transaction_id
  end

  def call
    response = query_payment

    if success?(response)
      Nets::Payment.new(response)
    else
      raise Nets::Error, response
    end
  end

  private

  def query_payment
    Nets::Client.new('/Netaxept/Query.aspx', payload).call
  end

  def payload
    { transaction_id: @transaction_id }
  end

  def success?(response)
    response['PaymentInfo'].present?
  end
end
