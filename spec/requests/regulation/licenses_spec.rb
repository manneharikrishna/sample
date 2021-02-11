require 'rails_helper'

RSpec.describe 'Licenses API' do
  let(:headers) { authorization_header(:regulator) }
  let(:path) { '/regulation/licenses' }

  let!(:license) { create(:license) }

  it 'returns a list of licenses' do
    get path, headers: headers

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

  it 'creates a license' do
    params = load_json_fixture(:license)

    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['id']).to be_a(Numeric)
    expect(json_response['name']).to eq(params['name'])
    expect(json_response['lottery_type']).to eq(params['lottery_type'])
    expect(json_response['min_duration']).to eq(params['min_duration'])
    expect(json_response['max_duration']).to eq(params['max_duration'])
    expect(json_response['max_tickets_count']).to eq(params['max_tickets_count'])
    expect(json_response['max_total_revenue']).to eq(params['max_total_revenue'])
    expect(json_response['min_payback_ratio']).to eq(params['min_payback_ratio'])
    expect(json_response['max_payback_ratio']).to eq(params['max_payback_ratio'])
  end

  it 'updates license details' do
    params = { name: 'Updated License' }

    patch "#{path}/#{license.id}", params: params, headers: headers

    expect(response).to have_http_status(200)
    expect(json_response['name']).to eq(params[:name])
  end

  it 'deletes a license' do
    delete "#{path}/#{license.id}", headers: headers

    expect(response).to have_http_status(200)
    expect(License.exists?(license.id)).to eq(false)
  end
end
