require 'rails_helper'

RSpec.describe RegisterTransactionsInAccountingJob do
  subject { described_class.perform_later('deposit') }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(RegisterTransactionsInAccountingJob)
  end

  it 'registers transactions in accounting' do
    expect_any_instance_of(RegisterTransactionsInAccounting).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
