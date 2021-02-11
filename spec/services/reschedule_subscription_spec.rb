require 'rails_helper'

RSpec.describe RescheduleSubscription do
  let(:subscription) { create :subscription }
  let(:drawing) { create :drawing }

  let(:deposit) { create(:deposit, status: 'failed') }

  subject { described_class.new(subscription, drawing) }

  context 'with failed deposit' do
    it 'it delays the drawing subscription' do
      expect { subject.call }.to enqueue_job(SubscribeDrawingJob)
    end

    it 'sends payment failure email' do
      expect { subject.call }.to enqueue_job.on_queue('mailers')
    end
  end
end
