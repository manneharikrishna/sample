require 'rails_helper'

RSpec.describe 'Lottery Drawings API' do
  let(:headers) { authorization_header(:regulator) }
  let(:path) { "/regulation/lotteries/#{lottery.id}/drawings" }

  let(:lottery) { create(:lottery) }

  before { create_list(:drawing, 3, lottery: lottery) }

  it 'returns a list of lottery drawings' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty
    expect(json_response.count).to eq(3)

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('starts_at')
    expect(json_response[0]).to include('ends_at')
  end
end
