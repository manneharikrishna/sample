require 'rails_helper'

RSpec.describe 'Session API' do
  let(:accountant) { create(:accountant, password: password) }
  let(:password) { 'password' }

  let(:path) { '/accountancy/session' }
  let(:params) { { email: accountant.email, password: password } }

  describe 'POST /accountancy/session' do
    subject! { post path, params: params }

    it 'returns the 201 status' do
      expect(response).to have_http_status(201)
    end

    it 'returns the session details' do
      expect(json_response['token']).to be_present
      expect(json_response['currency']).to be_present
      expect(json_response['accountant']).to be_present
    end
  end
end
