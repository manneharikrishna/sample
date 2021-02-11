require 'rails_helper'

RSpec.describe TrackProfileChangeJob do
  let(:player) { create(:player) }

  subject { described_class.perform_later(player) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(TrackProfileChangeJob)
  end

  it 'tracks a profile change' do
    expect_any_instance_of(TrackProfileChange).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
