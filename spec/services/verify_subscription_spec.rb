require 'rails_helper'

RSpec.describe VerifySubscription, nets: true do
  let(:subscription) { create(:subscription, tickets_count: 10, status: 'inactive') }
  let(:deposit) do
    create(:deposit, amount: 100, status: 'pending', player: subscription.player)
  end
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  subject { described_class.new(subscription, deposit, drawing) }

  it 'verifies the deposit' do
    expect_any_instance_of(Deposits::Verify).to receive(:call)
    subject.call
  end

  it 'activates the subscription' do
    expect_any_instance_of(ActivateSubscription).to receive(:call)
    subject.call
  end

  it 'creates an subscription entry' do
    expect_any_instance_of(CreateSubscriptionEntry).to receive(:call)
    subject.call
  end

  context 'with not started drawing' do
    before { drawing.state_machine.transition_to!(:ended) }

    it 'do not verify the deposit' do
      expect_any_instance_of(Deposits::Verify).to_not receive(:call)
      subject.call
    end

    it 'do not activate the subscription' do
      expect_any_instance_of(ActivateSubscription).to_not receive(:call)
      subject.call
    end

    it 'do not create an subscription entry' do
      expect_any_instance_of(CreateSubscriptionEntry).to_not receive(:call)
      subject.call
    end
  end
end
