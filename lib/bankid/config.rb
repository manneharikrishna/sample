module BankID
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    COUNTRIES = { NO: 'Norway', SE: 'Sweden' }.freeze

    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :redirect_uri
    attr_accessor :token_url
    attr_accessor :country

    def initialize
      @client_id = ENV['BANKID_CLIENT_ID']
      @client_secret = ENV['BANKID_CLIENT_SECRET']
      @redirect_uri = ENV['BANKID_REDIRECT_URI']
      @token_url = ENV['BANKID_TOKEN_URL']
      @country = COUNTRIES[COUNTRY_CODE.to_sym]
    end
  end
end
