require 'rails_helper'

RSpec.describe 'Password API' do
  let(:headers) { authorization_header(:operator) }

  it 'changes the password' do
    params = load_json_fixture(:password)

    patch '/admin/password', params: params, headers: headers

    expect(response).to have_http_status(200)
  end
end
