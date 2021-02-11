require 'rails_helper'

RSpec.describe SessionToken do
  let(:player) { create(:player) }
  let(:decoded_token) { JSONWebToken.decode(subject) }

  subject! { described_class.new(player).generate }

  it 'has a specific type' do
    expect(decoded_token[:type]).to eq('session')
  end

  it 'is assigned to a player' do
    expect(decoded_token[:player_id]).to eq(player.id)
  end

  it 'contains the player email' do
    expect(decoded_token[:email]).to eq(player.email)
  end

  it 'expires after 2 hours' do
    travel(3.hours) do
      expect(decoded_token).to be_nil
    end
  end
end
