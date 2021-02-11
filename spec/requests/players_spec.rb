require 'rails_helper'

RSpec.describe 'Players API', bankid: true do
  let(:params) do
    { bankid_code: 'uss.1nUyA5-B8tIo44CnJ0obtBbfjRAv-zwvq5S6fRX1i-A' }
  end

  it 'creates a player' do
    post '/players', params: params

    expect(response).to have_http_status(201)

    expect(Player.count).to eq(1)

    expect(json_response['token']).to be_present
    expect(json_response['currency']).to be_present
    expect(json_response['player']).to be_present
    expect(json_response['limits']).to be_present
    expect(json_response['player']).to be_present
    expect(json_response['limits']).to be_present

    expect(json_response['player']['first_name']).to be_present
    expect(json_response['player']['last_name']).to be_present
    expect(json_response['player']['birthdate']).to be_present
    expect(json_response['player']['email']).to be_nil
    expect(json_response['player']['phone_number']).to be_nil
    expect(json_response['player']['bank_account_number']).to be_nil
    expect(json_response['player']['suspended_until']).to be_nil
    expect(json_response['player']['weekly_loss_limit']).to be_nil
    expect(json_response['player']['daily_loss_limit']).to be_nil
    expect(json_response['player']['language']).to be_nil
    expect(json_response['player']['is_activated']).to eq(false)
    expect(json_response['player']['onboarding']).to eq(true)
    expect(json_response['player']['information']).to eq(false)

    expect(json_response['limits']['balance_limit']).to be_present
    expect(json_response['limits']['transfer_limit']).to be_present
    expect(json_response['limits']['weekly_loss_limit']).to be_present
    expect(json_response['limits']['daily_loss_limit']).to be_present
  end

  context 'when the player is already created' do
    before { create(:player, ssn: '03078113870') }

    it 'returns session details' do
      post '/players', params: params

      expect(response).to have_http_status(201)

      expect(Player.count).to eq(1)

      expect(json_response['token']).to be_present
      expect(json_response['currency']).to be_present
      expect(json_response['player']).to be_present
      expect(json_response['limits']).to be_present
      expect(json_response['player']).to be_present
      expect(json_response['limits']).to be_present
    end
  end
end
