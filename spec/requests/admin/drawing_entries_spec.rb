require 'rails_helper'

RSpec.describe 'Drawing Entries API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { "/admin/drawings/#{drawing.id}/entries" }

  let(:drawing) { create(:social_lottery_drawing, :started) }
  let(:entry) { drawing.entries.pending.take }

  it 'returns a list of drawing entries' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_a(Hash)

    expect(json_response['entries']).to be_an(Array)
    expect(json_response['entries']).not_to be_empty

    expect(json_response['entries'][0]).to include('id')
    expect(json_response['entries'][0]).to include('photo')
    expect(json_response['entries'][0]).to include('player')
    expect(json_response['entries'][0]).to include('status')

    expect(json_response['meta']['total_pages']).to eq(1)
  end

  it 'updates drawing entry details' do
    params = { status: 'approved' }

    patch "#{path}/#{entry.id}", params: params, headers: headers

    expect(response).to have_http_status(200)
    expect(json_response['status']).to eq(params[:status])
  end
end
