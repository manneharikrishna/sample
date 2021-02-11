require 'rails_helper'

RSpec.describe 'Drawing Winnings API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { "/admin/drawings/#{drawing.id}/winnings" }

  let(:drawing) { create(:pool_lottery_drawing) }

  before { CreateWinning.new(drawing).call }

  it 'returns a list of drawing winnings' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('created_at')
    expect(json_response[0]).to include('ticket')

    expect(json_response[0]['ticket']).to include('id')
    expect(json_response[0]['ticket']).to include('entry')

    expect(json_response[0]['ticket']['entry']).to include('player')
    expect(json_response[0]['ticket']['entry']).to include('photo')
  end
end
