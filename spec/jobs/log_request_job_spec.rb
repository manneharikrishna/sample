require 'rails_helper'

RSpec.describe LogRequestJob do
  subject { described_class.perform_later({}) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(LogRequestJob)
  end

  it 'logs the request' do
    expect_any_instance_of(LogRequest).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
