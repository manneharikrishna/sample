require 'rails_helper'

RSpec.describe 'Profile API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/profile' }

  let(:player) { current_player }

  it 'returns profile details' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['first_name']).to eq(player.first_name)
    expect(json_response['last_name']).to eq(player.last_name)
    expect(json_response['birthdate']).to be_present
    expect(json_response['email']).to eq(player.email)
    expect(json_response['phone_number']).to be_present
    expect(json_response['bank_account_number']).to be_present
    expect(json_response['language']).to be_present
    expect(json_response['is_activated']).to eq(true)
    expect(json_response['avatar']).to be_present

    expect(json_response['avatar']['url']).to be_present
    expect(json_response['avatar']['thumbnail_url']).to be_present

    expect(json_response['id']).not_to be_present
    expect(json_response['password']).not_to be_present
    expect(json_response['password_digest']).not_to be_present
    expect(json_response['ssn']).not_to be_present
  end

  it 'updates profile details' do
    params = load_json_fixture(:player)

    patch path, params: params, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['first_name']).to eq(params['first_name'])
    expect(json_response['last_name']).to eq(params['last_name'])
    expect(json_response['phone_number']).to eq(params['phone_number'])
    expect(json_response['bank_account_number']).to eq(params['bank_account_number'])
    expect(json_response['language']).to eq(params['language'])
  end
end
