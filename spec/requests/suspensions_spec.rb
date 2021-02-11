require 'rails_helper'

RSpec.describe 'Suspension API' do
  let(:headers) { authorization_header(:player) }
  let(:params) { { suspended_until: 1.month.from_now } }

  it 'creates a suspension' do
    post '/suspension', params: params, headers: headers

    expect(response).to have_http_status(201)
    expect(json_response['suspended_until']).to be_present
  end
end
