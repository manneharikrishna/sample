module BankID; end
module BankID::Norway; end
module BankID::Sweden; end

require 'bankid/config'
require 'bankid/error'

require 'bankid/token'

require 'bankid/user'
require 'bankid/norway/user'
require 'bankid/sweden/user'
