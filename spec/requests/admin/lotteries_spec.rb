require 'rails_helper'

RSpec.describe 'Lotteries API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { '/admin/lotteries' }

  let!(:license) { create(:license) }
  let!(:lottery) { create(:lottery) }

  it 'returns a list of lotteries' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('name')
    expect(json_response[0]).to include('type')
    expect(json_response[0]).to include('status')
    expect(json_response[0]).to include('headline')
    expect(json_response[0]).to include('description')
    expect(json_response[0]).to include('starts_at')
    expect(json_response[0]).to include('ends_at')
    expect(json_response[0]).to include('tickets_count')
    expect(json_response[0]).to include('ticket_price')
    expect(json_response[0]).to include('payback_ratio')
    expect(json_response[0]).to include('cover_url')
    expect(json_response[0]).to include('license')
    expect(json_response[0]).to include('repeat_every')

    expect(json_response[0]).not_to include('prizes')
  end

  it 'creates a lottery' do
    params = load_json_fixture(:new_lottery)
    params['license_id'] = license.id

    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['id']).to be_a(Numeric)
    expect(json_response['name']).to eq(params['name'])
    expect(json_response['type']).to eq(license.lottery_type)
    expect(json_response['status']).to eq('pending')
  end

  it 'returns lottery details' do
    get "#{path}/#{lottery.id}", headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['id']).to eq(lottery.id)
    expect(json_response['name']).to eq(lottery.name)
    expect(json_response['type']).to eq(lottery.type)
    expect(json_response['status']).to eq(lottery.status.to_s)
    expect(json_response['headline']).to eq(lottery.headline)
    expect(json_response['description']).to eq(lottery.description)
    expect(json_response['starts_at']).to eq(lottery.starts_at.as_json)
    expect(json_response['ends_at']).to eq(lottery.ends_at.as_json)
    expect(json_response['cover_url']).to eq(lottery.cover.url)
    expect(json_response['license']).to be_present
    expect(json_response['repeat_every']).to be_present
  end

  it 'updates lottery details' do
    params = load_json_fixture(:lottery)

    patch "#{path}/#{lottery.id}", params: params, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['name']).to eq(params['name'])
    expect(json_response['headline']).to eq(params['headline'])
    expect(json_response['description']).to eq(params['description'])
    expect(json_response['starts_at']).to eq(params['starts_at'])
    expect(json_response['ends_at']).to eq(params['ends_at'])
    expect(json_response['cover_url']).to be_present
    expect(json_response['repeat_every']).to be_present
  end

  it 'deletes a lottery' do
    delete "#{path}/#{lottery.id}", headers: headers

    expect(response).to have_http_status(200)
    expect(Lottery.exists?(lottery.id)).to eq(false)
  end
end
