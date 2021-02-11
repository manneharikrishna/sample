require 'rails_helper'

RSpec.describe 'Transactions API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/wallet/transactions' }

  let!(:entry) { create(:entry, player: current_player) }
  let!(:prize) { create(:prize, prizeable: entry.drawing) }
  let!(:ticket) { create(:ticket, :revealed, entry: entry, prize: prize) }

  before do
    create(:deposit, player: current_player, amount: 10.0)
    create(:payment, player: current_player, amount: -2.0, entry: entry)
  end

  it 'returns a list of transactions' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['transactions']).to be_an(Array)
    expect(json_response['transactions']).not_to be_empty

    expect(json_response['transactions'][0]).to include('type')
    expect(json_response['transactions'][0]).to include('amount')
    expect(json_response['transactions'][0]).to include('entry')
    expect(json_response['transactions'][0]).to include('created_at')
    expect(json_response['transactions'][0]).to include('status')

    expect(json_response['transactions'][0]['entry']).to include('drawing')

    expect(json_response['transactions'][0]['entry']['drawing']).to include('prizes')

    expect(json_response['transactions'][0]['entry']).to include('tickets')

    expect(json_response['transactions'][0]['entry']['tickets'][0]).to include('prize')

    expect(json_response['meta']['total_pages']).to eq(1)
  end
end
