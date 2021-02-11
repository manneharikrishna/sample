require 'rails_helper'

RSpec.describe VerifyToken do
  let(:player) { create(:player) }

  subject { described_class.new(token, :player, :session) }

  context 'when provided with a valid token' do
    let(:token) { SessionToken.new(player).generate }

    it 'returns a player' do
      expect(subject.call).to eq(player)
    end
  end

  context 'when provided with an invalid token' do
    let(:token) { JSONWebToken.encode(type: :invalid) }

    it 'returns nothing' do
      expect(subject.call).to be_nil
    end
  end
end
