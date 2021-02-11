require 'rails_helper'

RSpec.describe 'Drawing Entries API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { "/drawings/#{drawing.id}/entries" }
  let(:params) { load_json_fixture(:entry) }

  let(:drawing) { create(:pool_lottery_drawing, :started, ends_at: 1.day.from_now) }
  let(:photo) { create(:photo, player: current_player) }

  before do
    params['photo_id'] = photo.id
  end

  before do
    create(:deposit, amount: 100, player: current_player)
  end

  it 'creates a drawing entry' do
    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(json_response['id']).to be_a(Numeric)
    expect(json_response['tickets_count']).to be_present
    expect(json_response['created_at']).to be_present
    expect(json_response['photo']).to be_present
    expect(json_response['payment']).to be_present
    expect(json_response['tickets']).to be_present

    expect(json_response['payment']['amount']).to be_present

    expect(json_response['tickets'][0]).to include('id')
    expect(json_response['tickets'][0]).to include('serial_number')
    expect(json_response['tickets'][0]).to include('is_revealed')
    expect(json_response['tickets'][0]).to include('prize')
  end

  context 'when the player is suspended' do
    before do
      current_player.update!(suspended_until: 1.hour.from_now)
    end

    it 'returns the 403 status' do
      post path, params: params, headers: headers

      expect(response).to have_http_status(403)
    end
  end

  context 'when the drawing has ended' do
    before do
      drawing.update!(ends_at: 1.day.ago)
    end

    it 'returns the 403 status' do
      post path, params: params, headers: headers

      expect(response).to have_http_status(403)
    end
  end

  context "when player's funds are insufficient" do
    before do
      create(:payment, amount: -100, player: current_player)
    end

    it 'returns the 402 status' do
      post path, params: params, headers: headers

      expect(response).to have_http_status(402)
    end
  end

  context 'when the loss limit is exceeded' do
    before do
      current_player.update!(daily_loss_limit: 1)
    end

    it 'returns the 403 status' do
      post path, params: params, headers: headers

      expect(response).to have_http_status(403)
    end

    it 'returns the error message' do
      post path, params: params, headers: headers

      expect(json_response['errors']).to contain_error(:loss_limit_exceeded)
    end
  end
end
