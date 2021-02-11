require 'rails_helper'

RSpec.describe ActivateSubscription, nets: true, email: true do
  let(:subscription) { create(:subscription, player: player, status: 'inactive') }
  let(:deposit) { create(:deposit, player: player) }

  let!(:player) { create(:player) }
  let!(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  subject { described_class.new(subscription, deposit) }

  it 'activates the subscription' do
    subject.call

    expect(subscription.status).to eq('active')
    expect(subscription.nets_token).to be_present
    expect(subscription.payment_method).to be_present
    expect(subscription.card_expiration_date).to be_present
    expect(subscription.card_last_digits).to be_present
    expect(subscription.expires_on).to eq(1.year.from_now.to_date)
  end

  it 'sends an activated subscription email' do
    expect { subject.call }.to enqueue_job.on_queue('mailers')
  end

  it 'schedules expiration reminder email' do
    expect { subject.call }.to enqueue_job(SendSubscriptionExpirationEmailJob)
  end

  it 'schedules subscription cancelling job' do
    expect { subject.call }.to enqueue_job(CancelExpiredSubscriptionJob)
  end

  context 'when the deposit is not completed' do
    before { deposit.update!(status: 'pending') }

    it 'do not activate the subscription' do
      subject.call
      expect(subscription.status).to eq('inactive')
    end
  end

  context 'when the active player subscription already exists' do
    before { create(:subscription, :active, player: player) }

    it 'do not activate the subscription' do
      subject.call
      expect(subscription.status).to eq('inactive')
    end
  end

  context 'when the deposit payment has failed' do
    before { deposit.update!(status: 'failed') }

    it 'does not activate the subscription' do
      subject.call
      expect(subscription.status).to eq('inactive')
    end
  end
end
