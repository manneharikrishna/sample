require 'rails_helper'

RSpec.describe 'Players API' do
  let(:headers) { authorization_header(:consultant) }
  let(:path) { '/consultancy/players' }

  let!(:players) { create_list(:player, 2) }

  describe 'GET /consultancy/players' do
    subject! { get path, headers: headers }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns a list of players' do
      expect(json_response).to be_an(Array)
      expect(json_response).not_to be_empty
    end
  end

  describe 'GET /consultancy/players/:id' do
    before { players[0].update!(ssn: '03078113870') }

    subject! { get "#{path}/#{players[0].id}", headers: headers }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns player details' do
      expect(json_response['id']).to eq(players[0].id)
      expect(json_response['first_name']).to eq(players[0].first_name)
      expect(json_response['last_name']).to eq(players[0].last_name)
      expect(json_response['email']).to eq(players[0].email)
      expect(json_response['phone_number']).to be_present
      expect(json_response['bank_account_number']).to be_present
      expect(json_response['language']).to be_present

      expect(json_response['suspended_until']).to be_nil
      expect(json_response['deactivated_at']).to be_nil
      expect(json_response['weekly_loss_limit']).to be_nil
      expect(json_response['daily_loss_limit']).to be_nil
      expect(json_response['is_activated']).to be_present
      expect(json_response['avatar']).to be_present

      expect(json_response['avatar']['url']).to be_present
      expect(json_response['avatar']['thumbnail_url']).to be_present

      expect(json_response['age']).to be_present
      expect(json_response['gender']).to be_present
      expect(json_response['balance']).to be_present
    end

    it 'does not return sensitive data' do
      expect(json_response['password']).not_to be_present
      expect(json_response['password_digest']).not_to be_present
      expect(json_response['ssn']).not_to be_present
    end
  end
end
