require 'support/fake_service'

class FakeMixpanel < FakeService
  post '/engage' do
    render :engage
  end
end
