class JSONWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    payload, _header = JWT.decode(token, SECRET_KEY)
    payload.with_indifferent_access
  rescue JWT::DecodeError
    nil
  end
end
