require 'rails_helper'

RSpec.describe 'Session API' do
  let(:password) { 'password' }
  let(:operator) { create(:operator, password: password) }

  it 'creates a session' do
    params = { email: operator.email, password: password }

    post '/admin/session', params: params

    expect(response).to have_http_status(201)

    expect(json_response['token']).to be_present
    expect(json_response['currency']).to be_present
    expect(json_response['operator']).to be_present
  end
end
