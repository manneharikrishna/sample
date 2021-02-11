require 'rails_helper'

RSpec.describe 'Balance API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/wallet/balance' }

  before do
    create(:deposit, player: current_player, amount: 10.0)
    create(:payment, player: current_player, amount: -2.0)
  end

  it 'returns the wallet balance' do
    get path, headers: headers

    expect(response).to have_http_status(200)
    expect(json_response['balance']).to eq('8.00')
  end
end
