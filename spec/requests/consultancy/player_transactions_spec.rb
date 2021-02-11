require 'rails_helper'

RSpec.describe 'Transactions API' do
  let(:headers) { authorization_header(:consultant) }
  let(:path) { "/consultancy/players/#{player.id}/transactions" }

  let(:params) { { page: 1, per_page: 3 } }
  let!(:player) { create(:player) }

  let!(:transactions) do
    create_list(:withdrawal, 3, player: player, amount: -100.0)
  end

  describe 'GET /consultancy/players/:id/transactions' do
    subject! { get path, headers: headers, params: params }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns a list of transactions' do
      expect(json_response[0]).to include('id')
      expect(json_response[0]).to include('type')
      expect(json_response[0]).to include('amount')
      expect(json_response[0]).to include('data')
      expect(json_response[0]).to include('status')
      expect(json_response[0]).to include('subscription_id')
      expect(json_response[0]).to include('created_at')
      expect(json_response[0]).to include('entry')
    end
  end
end
