require 'rails_helper'

RSpec.describe ResetSuspensionJob do
  let(:player) { create(:player, suspended_until: 1.day.from_now) }

  subject { described_class.perform_later(player) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(ResetSuspensionJob)
  end

  it 'resets the player suspension' do
    expect_any_instance_of(ResetSuspension).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
