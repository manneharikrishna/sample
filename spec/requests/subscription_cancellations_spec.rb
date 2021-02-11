require 'rails_helper'

RSpec.describe 'Subscription Cancellation API' do
  describe 'POST /subscription/cancellation' do
    let(:headers) { authorization_header(:player) }
    let(:path) { '/subscription/cancellation' }

    let!(:subscription) { create(:subscription, :active, player: current_player) }

    subject! { post path, headers: headers }

    it 'returns the 201 status' do
      expect(response).to have_http_status(201)
    end

    it 'cancels subscription' do
      expect(subscription.reload.status).to eq('cancelled')
    end
  end
end
