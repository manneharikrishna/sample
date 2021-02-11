require 'support/fake_service'

class FakeNets < FakeService
  post '/Netaxept/Register.aspx' do
    render :register, content_type: :xml
  end

  post '/Netaxept/Query.aspx' do
    if params['transactionId'] == 'unauthorized-cancelled'
      render :unauthorized_cancelled, content_type: :xml
    elsif params['transactionId'] == 'unauthorized-failed'
      render :unauthorized_failed, content_type: :xml
    else
      render :query, content_type: :xml
    end
  end

  post '/Netaxept/Process.aspx' do
    render :capture, content_type: :xml
  end
end
