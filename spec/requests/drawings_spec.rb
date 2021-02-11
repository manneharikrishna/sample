require 'rails_helper'

RSpec.describe 'Drawings API' do
  let!(:drawing) { create(:drawing, :started) }

  it 'returns a list of drawings' do
    get '/drawings'

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('name')
    expect(json_response[0]).to include('type')
    expect(json_response[0]).to include('headline')
    expect(json_response[0]).to include('description')
    expect(json_response[0]).to include('ends_at')
    expect(json_response[0]).to include('tickets_count')
    expect(json_response[0]).to include('ticket_price')
    expect(json_response[0]).to include('currency')
    expect(json_response[0]).to include('cover_url')
    expect(json_response[0]).to include('prizes')

    expect(json_response[0]).not_to include('status')
    expect(json_response[0]).not_to include('starts_at')
    expect(json_response[0]).not_to include('payback_ratio')
    expect(json_response[0]).not_to include('template_id')
    expect(json_response[0]).not_to include('tickets')
  end
end
