require 'rails_helper'

RSpec.describe 'Callbacks API' do
  let(:username) { ENV['NETS_CALLBACK_USERNAME'] }
  let(:password) { ENV['NETS_CALLBACK_PASSWORD'] }

  it 'handles a callback' do
    params = load_json_fixture(:callback)
    headers = basic_authorization_header(username, password)

    post '/callbacks', params: params, headers: headers

    expect(response).to have_http_status(200)
  end
end
