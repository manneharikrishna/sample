require 'rails_helper'

RSpec.describe 'Failed Session Attempts API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { '/admin/failed_session_attempts' }

  before do
    create(:failed_session_attempt, created_at: Time.current, counter: 2)
  end

  describe 'GET /admin/failed_session_attempts' do
    subject! { get path, headers: headers }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns failed session attempts counts' do
      expect(json_response['today']).to be_present
      expect(json_response['yesterday']).to be_present
      expect(json_response['week']).to be_present
      expect(json_response['last_week']).to be_present
      expect(json_response['percentage_today']).to be_present
      expect(json_response['all_today']).to be_present
      expect(json_response['status']).to be_present
    end
  end
end
