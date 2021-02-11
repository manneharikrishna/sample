require 'rails_helper'

RSpec.describe 'Ticket Reveal API' do
  let(:headers) { authorization_header(:player) }

  let(:prize) { create(:prize) }
  let(:entry) { create(:entry, player: current_player) }
  let(:drawing) { create(:drawing, ends_at: 1.day.ago) }
  let(:ticket) { create(:ticket, prize: prize, entry: entry, drawing: drawing) }

  it 'creates a ticket reveal' do
    post "/tickets/#{ticket.id}/reveal", headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['id']).to eq(ticket.id)
    expect(json_response['serial_number']).to be_present
    expect(json_response['is_revealed']).to be_present
    expect(json_response['prize']).to be_present
  end

  context 'when the ticket is already revealed' do
    let(:ticket) do
      create(:ticket, :revealed, prize: prize, entry: entry, drawing: drawing)
    end

    it 'returns the 403 status' do
      post "/tickets/#{ticket.id}/reveal", headers: headers
      expect(response).to have_http_status(403)
    end
  end

  context 'when the drawing has not ended' do
    let(:drawing) { create(:drawing) }

    it 'returns the 403 status' do
      post "/tickets/#{ticket.id}/reveal", headers: headers
      expect(response).to have_http_status(403)
    end
  end
end
