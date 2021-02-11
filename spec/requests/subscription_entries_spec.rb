require 'rails_helper'

RSpec.describe 'Subscription Entries API' do
  describe 'GET /subscription/entries' do
    let(:headers) { authorization_header(:player) }
    let(:params) { { drawing_id: drawing.id } }
    let(:path) { '/subscription/entries' }

    let!(:entry) { create(:entry, player: current_player, entry_type: 'subscription') }
    let(:drawing) { entry.drawing }
    let!(:ticket) do
      create(:ticket, drawing: drawing, player: current_player, entry: entry)
    end

    let!(:prize) { create(:prize, prizeable: entry.drawing) }
    let!(:payment) { create(:payment, entry: entry) }

    subject! { get path, params: params, headers: headers }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns a list of unrevealed subscription entries' do
      expect(json_response).to be_an(Array)
      expect(json_response).not_to be_empty

      expect(json_response[0]).to include('id')
      expect(json_response[0]).to include('tickets_count')
      expect(json_response[0]).to include('created_at')
      expect(json_response[0]).to include('drawing')
      expect(json_response[0]).to include('photo')
      expect(json_response[0]).to include('payment')
      expect(json_response[0]).to include('tickets')
      expect(json_response[0]).to include('entry_type')
      expect(json_response[0]).to include('is_revealed')
    end

    it 'returns entry details' do
      expect(json_response[0]['id']).to eq(entry.id)
      expect(json_response[0]['tickets_count']).to be_present
      expect(json_response[0]['created_at']).to be_present
      expect(json_response[0]['drawing']).to be_present
      expect(json_response[0]['photo']).to be_present
      expect(json_response[0]['payment']).to be_present
      expect(json_response[0]['tickets']).to be_present
      expect(json_response[0]['entry_type']).to eq('subscription')
      expect(json_response[0]['is_revealed']).to be_falsey

      expect(json_response[0]['drawing']['prizes']).to be_nil

      expect(json_response[0]['payment']['amount']).to be_present

      expect(json_response[0]['tickets'][0]['id']).to be_present
      expect(json_response[0]['tickets'][0]['serial_number']).to be_present
      expect(json_response[0]['tickets'][0]['is_revealed']).to be_falsey
      expect(json_response[0]['tickets'][0]['prize']).to be_nil
    end
  end
end
