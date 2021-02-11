require 'rails_helper'

RSpec.describe 'Entries API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/entries' }

  let!(:entry) { create(:entry, :revealed, player: current_player) }

  let!(:prize) { create(:prize, prizeable: entry.drawing) }
  let!(:payment) { create(:payment, entry: entry) }
  let!(:ticket) { create(:ticket, :revealed, entry: entry, prize: prize) }

  it 'returns a list of entries' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['entries']).to be_an(Array)
    expect(json_response['entries']).not_to be_empty

    expect(json_response['entries'][0]).to include('id')
    expect(json_response['entries'][0]).to include('tickets_count')
    expect(json_response['entries'][0]).to include('created_at')
    expect(json_response['entries'][0]).to include('drawing')
    expect(json_response['entries'][0]).to include('photo')
    expect(json_response['entries'][0]).to include('payment')
    expect(json_response['entries'][0]).to include('tickets')
    expect(json_response['entries'][0]).to include('entry_type')
    expect(json_response['entries'][0]).to include('is_revealed')

    expect(json_response['meta']['total_pages']).to eq(1)
  end

  it 'returns entry details' do
    get "#{path}/#{entry.id}", headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['id']).to eq(entry.id)
    expect(json_response['tickets_count']).to be_present
    expect(json_response['created_at']).to be_present
    expect(json_response['drawing']).to be_present
    expect(json_response['photo']).to be_present
    expect(json_response['payment']).to be_present
    expect(json_response['tickets']).to be_present
    expect(json_response['entry_type']).to be_nil
    expect(json_response['is_revealed']).to be_truthy

    expect(json_response['drawing']['prizes']).to be_present

    expect(json_response['payment']['amount']).to be_present

    expect(json_response['tickets'][0]['id']).to be_present
    expect(json_response['tickets'][0]['serial_number']).to be_present
    expect(json_response['tickets'][0]['is_revealed']).to be_present
    expect(json_response['tickets'][0]['prize']).to be_present
  end
end
