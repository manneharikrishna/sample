require 'rails_helper'

RSpec.describe 'Entry Reveals API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { "/entries/#{entry.id}/reveal" }

  let(:prize) { create(:prize) }
  let(:entry) { create(:entry, player: current_player, entry_type: 'subscription') }
  let!(:ticket) { create(:ticket, prize: prize, entry: entry) }
  let!(:payment) { create(:payment, entry: entry) }

  subject! { post path, headers: headers }

  it 'returns the 201 status' do
    expect(response).to have_http_status(201)
  end

  it 'creates a entry reveal' do
    expect(json_response['id']).to eq(entry.id)
    expect(json_response['tickets_count']).to be_present
    expect(json_response['created_at']).to be_present
    expect(json_response['drawing']).to be_present
    expect(json_response['photo']).to be_present
    expect(json_response['payment']).to be_present
    expect(json_response['tickets']).to be_present
    expect(json_response['entry_type']).to eq('subscription')
    expect(json_response['is_revealed']).to be_truthy
  end

  context 'when the entry is already revealed' do
    let(:entry) do
      create(:entry, :revealed, player: current_player)
    end

    it 'returns the 403 status' do
      expect(response).to have_http_status(403)
    end

    it 'returns the error message' do
      expect(json_response['errors']).to contain_error(:entry_revealed)
    end
  end
end
