class Nets::Error < StandardError
  def initialize(response)
    super(error_message(response) || response.code)
  end

  private

  def error_message(response)
    response['Exception']['Error']['Message']
  end
end
