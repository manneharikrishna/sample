require 'support/fake_service'

class FakeBankID < FakeService
  post '/oidc/token' do
    render :token
  end

  private

  def service_name
    'bankid'
  end
end
