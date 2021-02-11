require 'rails_helper'

RSpec.describe CreateSession do
  let(:password) { 'password' }
  let(:player) { create(:player, password: 'password') }

  subject { described_class.new(:player, player.email, password) }

  context 'when the player is activated' do
    before { player.activate }

    context 'when provided with valid credentials' do
      it 'creates a session' do
        expect(subject.call).to be_a(Session)
      end

      it 'schedules sign-in tracking' do
        expect { subject.call }.to enqueue_job(TrackSignInJob)
      end
    end

    context 'when provided with invalid credentials' do
      let(:password) { 'invalid' }

      it 'raises an error' do
        expect { subject.call }.to raise_error(ResponseError)
      end
    end
  end

  context 'when the player is not activated' do
    before { player.update(activated_at: nil) }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context 'when the player has been deactivated' do
    before { player.deactivate! }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
