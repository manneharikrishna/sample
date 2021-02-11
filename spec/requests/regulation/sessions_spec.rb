require 'rails_helper'

RSpec.describe 'Session API' do
  let(:password) { 'password' }
  let(:regulator) { create(:regulator, password: password) }

  it 'creates a session' do
    params = { email: regulator.email, password: password }

    post '/regulation/session', params: params

    expect(response).to have_http_status(201)

    expect(json_response['token']).to be_present
    expect(json_response['currency']).to be_present
  end
end
