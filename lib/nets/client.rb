class Nets::Client
  include HTTParty

  base_uri Nets.config.api_url

  def initialize(path, data)
    @path = path
    @data = data
  end

  def call
    self.class.post(@path, body: payload)
  end

  private

  def payload
    transform_keys(@data.merge(credentials))
  end

  def credentials
    {
      merchant_id: Nets.config.merchant_id,
      token: Nets.config.token
    }
  end

  def transform_keys(payload)
    payload.transform_keys { |k| k.to_s.camelize(:lower) }
  end
end
