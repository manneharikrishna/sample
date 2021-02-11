class KAR::Client
  include HTTParty

  base_uri "#{ENV['KAR_API_URL']}/kar-direct"

  pem ENV['KAR_CERTIFICATE'] if ENV['KAR_CERTIFICATE'].present?
  ssl_ca_file "#{__dir__}/certificates/nets.pem"

  def initialize(ssn, bank_account_number)
    @ssn = ssn
    @bank_account_number = bank_account_number
  end

  def call
    ownership_verified?(self.class.get(path))
  end

  private

  def path
    "/customers/#{@ssn}/accounts/#{@bank_account_number}/karVerifyAccountOwner"
  end

  def ownership_verified?(response)
    response.success? && response.body.match(/\A(01|02)&Ja/).present?
  end
end
