require 'rails_helper'

RSpec.describe 'Deactivation API' do
  let(:headers) { authorization_header(:player) }

  let(:path) { '/deactivation' }

  it 'deactivates the player' do
    post path, headers: headers

    expect(response).to have_http_status(200)

    expect(current_player.reload).to be_deactivated
  end
end
