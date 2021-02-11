class AppendTokenToUrl
  def initialize(url, token)
    @url = url
    @token = token
  end

  def call
    MergeUrlParameters.new(url, token: token).call
  end

  private

  attr_reader :url
  attr_reader :token
end
