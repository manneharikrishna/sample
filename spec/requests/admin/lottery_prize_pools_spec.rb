require 'rails_helper'

RSpec.describe 'Lottery Prize Pool API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { "/admin/lotteries/#{lottery.id}/prize_pool" }

  let(:lottery) { create(:predrawn_lottery) }

  it 'updates the lottery prize pool' do
    params = load_json_fixture(:predrawn_prize_pool)
    params['prizes'][0]['image'] = attributes_for(:prize)[:image]

    patch path, params: params, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['tickets_count']).to eq(params['tickets_count'])
    expect(json_response['ticket_price']).to eq(params['ticket_price'])
    expect(json_response['prizes']).to be_present

    expect(json_response['prizes'][0]['id']).to be_a(Numeric)
    expect(json_response['prizes'][0]['name']).to be_present
    expect(json_response['prizes'][0]['value']).to be_present
    expect(json_response['prizes'][0]['quantity']).to be_present
    expect(json_response['prizes'][0]['reveal_type']).to be_present
    expect(json_response['prizes'][0]['image_url']).to be_present
    expect(json_response['prizes'][0]['thumbnail_url']).to be_present
  end
end
