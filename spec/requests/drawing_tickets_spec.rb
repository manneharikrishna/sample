require 'rails_helper'

RSpec.describe 'Drawing Tickets API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { "/drawings/#{drawing.id}/tickets" }

  let!(:drawing) { create(:drawing, :started) }
  let!(:ticket) { create(:ticket, drawing: drawing, player: current_player) }

  subject { get path, headers: headers }

  context 'when the entry is revealed' do
    before { ticket.entry.update!(revealed_at: Time.current) }

    it 'returns a list of unrevealed drawing tickets' do
      subject

      expect(response).to have_http_status(200)

      expect(json_response).to be_an(Array)
      expect(json_response).not_to be_empty

      expect(json_response[0]).to include('id')
      expect(json_response[0]).to include('serial_number')
      expect(json_response[0]).to include('is_revealed')
      expect(json_response[0]).to include('photo')
      expect(json_response[0]).to include('prize')
    end
  end
end
