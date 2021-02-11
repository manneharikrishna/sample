ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.verbose_retry = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.fixture_path = 'spec/fixtures/files'

  config.include ActiveJob::TestHelper
  config.include ActionDispatch::TestProcess
  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryGirl::Syntax::Methods
  config.include RequestHelpers, type: :request
  config.include EmailHelpers, email: true

  config.before(:example, bankid: true) do
    stub_request(:any, /ident-preprod1.nets.eu/).to_rack(FakeBankID)
  end

  config.before(:example, nets: true) do
    stub_request(:any, /test.epayment.nets.eu/).to_rack(FakeNets)
  end

  config.before(:example, kar: true) do
    stub_request(:any, /ajour-test.nets.no/).to_rack(FakeKAR)
  end

  config.before(:example, mixpanel: true) do
    stub_request(:any, /api.mixpanel.com/).to_rack(FakeMixpanel)
  end

  def load_json_fixture(name)
    data = file_fixture("../#{name}.json").read
    JSON.parse(data).with_indifferent_access
  end
end
