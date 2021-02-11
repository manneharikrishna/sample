require 'rails_helper'

RSpec.describe 'Licenses API' do
  let(:headers) { authorization_header(:operator) }

  let!(:license) { create(:license) }

  it 'returns a list of licenses' do
    get '/admin/licenses', headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('name')
    expect(json_response[0]).to include('lottery_type')
    expect(json_response[0]).to include('min_duration')
    expect(json_response[0]).to include('max_duration')
    expect(json_response[0]).to include('max_tickets_count')
    expect(json_response[0]).to include('max_total_revenue')
    expect(json_response[0]).to include('min_payback_ratio')
    expect(json_response[0]).to include('max_payback_ratio')
  end
end
