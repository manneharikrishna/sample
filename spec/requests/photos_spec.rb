require 'rails_helper'

RSpec.describe 'Photos API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/photos' }

  let!(:photo) { create(:photo, player: current_player) }

  it 'returns a list of photos' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]['id']).to eq(photo.id)
    expect(json_response[0]['url']).to be_present
    expect(json_response[0]['thumbnail_url']).to be_present
    expect(json_response[0]['is_default']).to eq(false)
    expect(json_response[0]['is_played']).to eq(false)
    expect(json_response[0]['is_visible']).to eq(true)
    expect(json_response[0]['winning_count']).to be_present
  end

  it 'creates a photo' do
    params = { image: attributes_for(:photo)[:image] }

    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['url']).to be_present
    expect(json_response['thumbnail_url']).to be_present
    expect(json_response['is_default']).to eq(false)
    expect(json_response['is_played']).to eq(false)
    expect(json_response['is_visible']).to eq(true)
  end

  it 'deletes a photo' do
    delete "#{path}/#{photo.id}", headers: headers

    expect(response).to have_http_status(200)
    expect(Photo.exists?(photo.id)).to eq(false)
  end
end
