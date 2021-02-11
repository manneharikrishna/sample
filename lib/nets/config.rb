module Nets
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    attr_accessor :api_url
    attr_accessor :merchant_id
    attr_accessor :token
    attr_accessor :currency
    attr_accessor :payment_methods
    attr_accessor :languages

    def initialize
      @api_url = ENV['NETS_API_URL']
      @merchant_id = ENV['NETS_MERCHANT_ID']
      @token = ENV['NETS_TOKEN']
      @currency = CURRENCY
      @payment_methods = ENV['NETS_PAYMENT_METHODS']
      @languages = { en: 'en_GB', nn: 'no_NO', sv: 'sv_SE' }
    end
  end
end
