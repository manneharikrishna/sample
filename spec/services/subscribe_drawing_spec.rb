require 'rails_helper'

RSpec.describe SubscribeDrawing, nets: true, email: true do
  let(:subscription) { create(:subscription, :active, tickets_count: 10) }
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  subject { described_class.new(subscription, drawing) }

  it 'creates a deposit' do
    expect { subject.call }.to change { Deposit.count }.by(1)
    expect(Deposit.last.status).to eq('completed')
  end

  it 'assigns a subscription to deposit' do
    subject.call
    expect(Deposit.last.subscription).to eq(subscription)
  end

  it 'verifies the subscription deposit' do
    expect_any_instance_of(VerifySubscription).to receive(:call)
    subject.call
  end

  it 'creates an entry' do
    expect { subject.call }.to change { Entry.count }.by(1)
    expect(Deposit.last.status).to eq('completed')
  end

  context 'with not verified the subscription policy' do
    before { subscription.player.update!(suspended_until: 1.day.from_now) }

    it 'reschedules the subscription' do
      expect_any_instance_of(RescheduleSubscription).to receive(:call)
      subject.call
    end

    it 'does not create a deposit' do
      expect { subject.call }.not_to change { Deposit.count }
    end
  end

  context 'with failed deposit payment' do
    let(:deposit) do
      create(:deposit, player: subscription.player,
              nets_payment_id: 'unauthorized-failed')
    end

    before do
      allow_any_instance_of(Deposits::Create).to receive(:call).and_return(deposit)
    end

    it 'reschedules the subscription' do
      expect_any_instance_of(RescheduleSubscription).to receive(:call)
      subject.call
    end
  end

  context 'with Nets Error risen' do
    before do
      allow_any_instance_of(VerifySubscription).to receive(:call).and_return(Nets::Error)
    end

    it 'reschedules the subscription' do
      expect_any_instance_of(RescheduleSubscription).to receive(:call)
      subject.call
    end
  end
end
