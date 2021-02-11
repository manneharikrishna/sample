require 'rails_helper'

RSpec.describe 'Sessions API' do
  let(:password) { 'password' }
  let(:consultant) { create(:consultant, password: password) }

  let(:path) { '/consultancy/session' }
  let(:params) { { email: consultant.email, password: password } }

  describe 'POST /consultancy/session' do
    subject! { post path, params: params }

    it 'returns the 201 status' do
      expect(response).to have_http_status(201)
    end

    it 'returns the session details' do
      expect(json_response['token']).to be_present
      expect(json_response['currency']).to be_present
      expect(json_response['consultant']).to be_present
    end
  end
end
