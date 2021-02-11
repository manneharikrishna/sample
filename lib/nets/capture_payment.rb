class Nets::CapturePayment
  def initialize(transaction_id)
    @transaction_id = transaction_id
  end

  def call
    response = capture_payment

    if success?(response)
      true
    else
      raise Nets::Error, response
    end
  end

  private

  def capture_payment
    Nets::Client.new('/Netaxept/Process.aspx', payload).call
  end

  def payload
    {
      operation: 'CAPTURE',
      transaction_id: @transaction_id
    }
  end

  def success?(response)
    response['ProcessResponse'].present?
  end
end
