require 'rails_helper'

RSpec.describe 'Session API' do
  let(:password) { 'password' }
  let(:player) { create(:player, password: password) }

  before { player.activate }

  it 'creates a session' do
    params = { email: player.email, password: password }

    post '/session', params: params

    expect(response).to have_http_status(201)

    expect(json_response['token']).to be_present
    expect(json_response['currency']).to be_present
    expect(json_response['player']).to be_present
    expect(json_response['limits']).to be_present

    expect(json_response['player']['avatar']).to be_present

    expect(json_response['limits']['balance_limit']).to be_present
    expect(json_response['limits']['transfer_limit']).to be_present

    expect(json_response['limits']['weekly_loss_limit']).to be_present
    expect(json_response['limits']['daily_loss_limit']).to be_present
  end
end
