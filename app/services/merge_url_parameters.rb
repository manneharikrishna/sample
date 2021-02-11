class MergeUrlParameters
  def initialize(url, params)
    @uri = Addressable::URI.parse(url)
    @params = params.stringify_keys
  end

  def call
    merge_parameters
    generate_url
  end

  private

  attr_reader :uri
  attr_reader :params

  def merge_parameters
    query_values = uri.query_values || {}
    query_values.merge!(params)

    uri.query_values = query_values
  end

  def generate_url
    uri.to_s
  end
end
