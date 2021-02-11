class ApplicationToken
  def generate
    JSONWebToken.encode(payload)
  end

  private

  def payload
    { type: type, exp: expires_at.to_i }
  end

  def type
    self.class.name.underscore.rpartition('_')[0]
  end

  def expires_at
    24.hours.from_now
  end
end
