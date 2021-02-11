require 'rails_helper'

RSpec.describe TrackSignInJob do
  let(:player) { create(:player) }

  subject { described_class.perform_later(player) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(TrackSignInJob)
  end

  it 'tracks a sign-in' do
    expect_any_instance_of(TrackSignIn).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
