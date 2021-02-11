require 'rails_helper'

RSpec.describe 'Password API' do
  let(:headers) { authorization_header(:player) }

  it 'changes the password' do
    params = load_json_fixture(:password)

    patch '/password', params: params, headers: headers

    expect(response).to have_http_status(200)
  end
end
