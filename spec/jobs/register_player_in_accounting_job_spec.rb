require 'rails_helper'

RSpec.describe RegisterPlayerInAccountingJob do
  let(:player) { create(:player) }

  subject { described_class.perform_later(player) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(RegisterPlayerInAccountingJob)
  end

  it 'registers the player in accounting' do
    expect_any_instance_of(RegisterPlayerInAccounting).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
