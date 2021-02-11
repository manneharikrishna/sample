class Nets::Transaction
  def initialize(data)
    @data = data
  end

  def id
    @data['RegisterResponse']['TransactionId']
  end

  def redirect_url
    "#{api_url}/Terminal/default.aspx?merchantId=#{merchant_id}&transactionId=#{id}"
  end

  private

  def api_url
    Nets.config.api_url
  end

  def merchant_id
    Nets.config.merchant_id
  end
end
