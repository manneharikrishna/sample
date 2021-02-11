require 'rspec/expectations'

RSpec::Matchers.define :be_now do
  match do |actual|
    actual.to_i == Time.current.to_i
  end
end
