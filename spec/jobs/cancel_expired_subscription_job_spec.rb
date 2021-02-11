require 'rails_helper'

RSpec.describe CancelExpiredSubscriptionJob do
  let!(:subscription) { create(:subscription, :active, :expired) }

  subject { described_class.perform_later(subscription) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(CancelExpiredSubscriptionJob)
  end

  it 'cancels the subscription' do
    expect_any_instance_of(CancelExpiredSubscription).to receive(:call)
    perform_enqueued_jobs { subject }
  end

  context 'when the subscription has not expired' do
    before { subscription.update!(expires_on: 1.year.from_now) }

    it 'does not enqueue the job' do
      expect_any_instance_of(CancelExpiredSubscription).not_to receive(:call)
      perform_enqueued_jobs { subject }
    end
  end
end
