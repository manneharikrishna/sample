module TwentyFourSevenOffice
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    API_URL = 'https://api.24sevenoffice.com'.freeze
    WEBSERVICES_URL = 'https://webservices.24sevenoffice.com'.freeze

    AUTHENTICATE_WSDL = "#{API_URL}/authenticate/v001/authenticate.asmx?wsdl".freeze
    COMPANY_SERVICE_WSDL = "#{API_URL}/CRM/Company/V001/CompanyService.asmx?wsdl".freeze
    ACCOUNT_SERVICE_WSDL = "#{WEBSERVICES_URL}/economy/accountV002/Accountservice.asmx?wsdl".freeze

    attr_accessor :username
    attr_accessor :password
    attr_accessor :application_id
    attr_accessor :identity_id
    attr_accessor :xml_view_path

    def initialize
      @username = ENV['TWENTY_FOUR_SEVEN_OFFICE_USERNAME']
      @password = encode_password(ENV['TWENTY_FOUR_SEVEN_OFFICE_PASSWORD'])
      @application_id = ENV['TWENTY_FOUR_SEVEN_OFFICE_APPLICATION_ID']
      @identity_id = ENV['TWENTY_FOUR_SEVEN_OFFICE_IDENTITY_ID']
      @xml_view_path = 'lib/24sevenoffice/xml'.freeze
    end

    private

    def encode_password(password)
      OpenSSL::Digest.new('md5', password.encode('UTF-16le')).to_s
    end
  end
end
