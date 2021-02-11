class BankID::Token
  include HTTParty

  base_uri BankID.config.token_url

  def initialize(code)
    @code = code
  end

  def call
    response = self.class.post('/oidc/token', body: payload, headers: headers)

    if response.success?
      bankid_user_class.new(decode_token(response['id_token']))
    else
      raise BankID::Error, response
    end
  end

  private

  def headers
    { authorization: "Basic #{encoded_credentials}" }
  end

  def payload
    {
      grant_type: :authorization_code,
      redirect_uri: BankID.config.redirect_uri,
      code: @code
    }
  end

  def encoded_credentials
    Base64.encode64("#{BankID.config.client_id}:#{BankID.config.client_secret}")
  end

  def bankid_user_class
    "BankID::#{BankID.config.country}::User".constantize
  end

  def decode_token(token)
    JWT.decode(token, nil, false)[0]
  end
end
