require 'rails_helper'

RSpec.describe VerifySubscriptionPolicy do
  let(:player) { create(:player) }

  let(:subscription) { create(:subscription, :active, player: player) }
  let(:amount) { 100 }

  subject { described_class.new(player, amount) }

  it 'verifies the subscription policy' do
    expect(subject.call).to be_truthy
  end

  context 'with the suspended player' do
    before { player.update!(suspended_until: 1.day.from_now) }

    it ' does not verify the subscription policy' do
      expect(subject.call).to be_falsey
    end
  end

  context 'with loss limits exceeded' do
    before { player.update!(daily_loss_limit: 1) }

    it ' does not verify the subscription policy' do
      expect(subject.call).to be_falsey
    end
  end

  context 'with balance exceeded' do
    let(:amount) { 10_000 }

    it ' does not verify the subscription policy' do
      expect(subject.call).to be_falsey
    end
  end
end
