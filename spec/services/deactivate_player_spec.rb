require 'rails_helper'

RSpec.describe DeactivatePlayer do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  it 'deactivates a player' do
    subject.call
    expect(player.deactivated?).to be_truthy
  end

  context 'with an active subscription' do
    let!(:subscription) { create(:subscription, :active, player: player) }

    it 'cancels the subscription' do
      expect_any_instance_of(CancelSubscription).to receive(:call)
      subject.call
    end
  end
end
