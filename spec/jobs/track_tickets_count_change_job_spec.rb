require 'rails_helper'

RSpec.describe TrackTicketsCountChangeJob do
  let(:player) { create(:player) }
  let(:tickets_count) { 10 }

  subject { described_class.perform_later(player, tickets_count) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(TrackTicketsCountChangeJob)
  end

  it 'tracks a tickets count change' do
    expect_any_instance_of(TrackTicketsCountChange).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
