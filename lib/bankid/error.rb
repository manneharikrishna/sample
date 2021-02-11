class BankID::Error < StandardError
  def initialize(response)
    super(response['error_description'] || response.code)
  end
end
