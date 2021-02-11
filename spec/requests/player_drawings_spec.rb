require 'rails_helper'

RSpec.describe 'Player Drawings API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/player/drawings' }

  let!(:ended_drawing) { create(:drawing, :ended) }
  let!(:drawing) { create(:drawing, :started) }

  it 'returns a list of drawings' do
    get path, headers: headers

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
    expect(json_response[0]).not_to include('license')
  end

  it 'returns drawing summary' do
    get "#{path}/#{drawing.id}", headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to include('weekly_tickets_count')
    expect(json_response['weekly_tickets_count']).to be_an(Integer)
    expect(json_response).to include('subscription_tickets_count')
    expect(json_response['subscription_tickets_count']).to be_an(Integer)
    expect(json_response).to include('drawing_revenue')
    expect(json_response['drawing_revenue']).to be_an(Integer)

    expect(json_response).not_to include('player')
    expect(json_response).not_to include('weekly_tickets')
    expect(json_response).not_to include('subscription_tickets')
  end
end
