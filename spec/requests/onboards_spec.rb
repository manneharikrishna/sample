require 'rails_helper'

RSpec.describe 'Onboards API' do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/onboard' }

  context 'with new player' do
    before { current_player.update!(onboarding: true, information: false) }

    it 'updates player onboarding parameter' do
      patch path, headers: headers

      expect(response).to have_http_status(200)

      expect(json_response['onboarding']).to be(false)
    end
  end

  context 'with returning player' do
    before { current_player.update!(onboarding: false, information: true) }

    it 'updates player information parameter' do
      patch path, headers: headers

      expect(response).to have_http_status(200)

      expect(json_response['information']).to be(false)
    end
  end
end
