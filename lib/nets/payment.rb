class Nets::Payment
  def initialize(data)
    @data = data.to_h
  end

  def authorized?
    @data['PaymentInfo']['Summary']['Authorized'] == 'true'
  end

  def captured?(amount)
    @data['PaymentInfo']['Summary']['AmountCaptured'].to_i == (amount * 100).to_i
  end

  def cancelled?
    return unless @data['PaymentInfo']['Error'].present?
    @data['PaymentInfo']['Error']['ResponseCode'] == '17'
  end

  def token
    @data['PaymentInfo']['CardInformation']['PanHash']
  end

  def payment_method
    @data['PaymentInfo']['CardInformation']['PaymentMethod']
  end

  def card_expiration_date
    month = expiry_date.chars.last(2).join
    year = expiry_date.chars.first(2).join

    "#{month}/#{year}"
  end

  def expiry_date
    @data['PaymentInfo']['CardInformation']['ExpiryDate']
  end

  def card_last_digits
    @data['PaymentInfo']['CardInformation']['MaskedPAN'].chars.last(4).join
  end
end
