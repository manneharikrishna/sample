require 'rspec/expectations'

RSpec::Matchers.define :contain_error do |expected|
  match do |actual|
    message = I18n.t(expected, scope: 'errors.messages')
    actual.include?(message)
  end
end
