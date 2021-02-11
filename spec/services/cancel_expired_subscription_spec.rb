require 'rails_helper'

RSpec.describe CancelExpiredSubscription, email: true do
  let!(:subscription) { create(:subscription, :active, :expired, player: player) }
  let(:player) { create(:player) }

  subject { described_class.new(player, subscription) }

  it 'cancels the subscription' do
    subject.call
    expect(subscription.reload.status).to eq('cancelled')
  end

  it 'sends subscription cancellation email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end

  it 'removes subscription token' do
    subject.call
    expect(subscription.reload.nets_token).to eq(nil)
  end
end
