require 'rails_helper'

RSpec.describe CreateSubscriptionEntry do
  let(:subscription) { create(:subscription, tickets_count: 10, status: 'active') }
  let(:deposit) { create(:deposit, amount: 100, player: subscription.player) }
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  subject { described_class.new(subscription, deposit, drawing) }

  it 'creates an entry' do
    expect { subject.call }.to change { Entry.count }.by(1)
  end

  it 'assigns the entry to the deposit' do
    subject.call
    expect(deposit.reload.entry).to be_present
  end

  context 'when the subscription is not active' do
    before { subscription.update!(status: 'inactive') }

    it 'do not creates an entry' do
      expect { subject.call }.to_not change { Entry }
    end
  end

  context 'when the deposit is used' do
    before { deposit.update!(entry: create(:entry)) }

    it 'do not creates an entry' do
      expect { subject.call }.to_not change { Entry }
    end
  end
end
