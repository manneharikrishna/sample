require 'rails_helper'

RSpec.describe 'Deposits API', nets: true do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/wallet/deposits' }

  let(:deposit) { create(:deposit, player: current_player, amount: 100) }

  it 'creates a deposit transaction' do
    params = load_json_fixture(:deposit)

    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['id']).to be_a(Numeric)
    expect(json_response['amount']).to be_present
  end

  it 'completes the deposit transaction' do
    patch "#{path}/#{deposit.id}", headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['id']).to eq(deposit.id)
    expect(json_response['amount']).to eq('100.00')
    expect(json_response['status']).to eq('completed')
  end

  context 'when the payment is not authorized' do
    before { deposit.update!(nets_payment_id: 'unauthorized-cancelled') }

    it 'returns the status of the deposit transaction' do
      patch "#{path}/#{deposit.id}", headers: headers

      expect(response).to have_http_status(200)

      expect(json_response['id']).to eq(deposit.id)
      expect(json_response['status']).to eq('cancelled')
    end
  end
end
