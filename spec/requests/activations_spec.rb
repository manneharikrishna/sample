require 'rails_helper'

RSpec.describe 'Activation API' do
  let(:current_player) { Player.create!(birthdate: 18.years.ago) }

  let(:headers) { authorization_header(:player) }
  let(:path) { '/activation' }
  let(:params) { load_json_fixture(:activation) }

  it 'activates the player' do
    post path, params: params, headers: headers

    expect(response).to have_http_status(201)

    expect(current_player.reload).to be_activated
    expect(current_player.is_pep).to eq(true)

    expect(json_response['first_name']).to be_present
    expect(json_response['last_name']).to be_present
    expect(json_response['birthdate']).to be_present
    expect(json_response['email']).to be_present
    expect(json_response['phone_number']).to be_nil
    expect(json_response['bank_account_number']).to be_nil
    expect(json_response['suspended_until']).to be_nil
    expect(json_response['weekly_loss_limit']).to be_nil
    expect(json_response['daily_loss_limit']).to be_nil
    expect(json_response['language']).to be_present
    expect(json_response['is_activated']).to eq(true)

    expect(json_response['id']).not_to be_present
    expect(json_response['password']).not_to be_present
    expect(json_response['password_digest']).not_to be_present
    expect(json_response['ssn']).not_to be_present
  end

  context 'when player provides not unified email' do
    before { params['email'] = ' Not.unified @Email.com ' }

    it 'returns unified player email' do
      unified_email = params['email'].downcase.gsub!(/\s+/, '')

      post path, params: params, headers: headers

      expect(response).to have_http_status(201)
      expect(json_response['email']).to eq(unified_email)
    end
  end

  context 'when the player is not authorized' do
    it 'returns the 401 status' do
      post path, params: params
      expect(response).to have_http_status(401)
    end
  end

  context 'when the player is already activated' do
    before { current_player.activate }

    it 'returns the 403 status' do
      post path, params: params, headers: headers
      expect(response).to have_http_status(403)
    end
  end
end
