require 'rails_helper'

RSpec.describe 'Withdrawals API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/wallet/withdrawals' }

  before { create(:deposit, player: current_player, amount: 1000) }

  it 'creates a withdrawal transaction' do
    params = load_json_fixture(:withdrawal)

    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['amount']).to be_present
    expect(json_response['created_at']).to be_present

    expect(json_response['id']).not_to be_present
  end
end
