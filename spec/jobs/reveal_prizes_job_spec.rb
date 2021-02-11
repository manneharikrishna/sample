require 'rails_helper'

RSpec.describe RevealPrizesJob do
  let(:drawing) { create(:drawing) }

  subject { described_class.perform_later(drawing) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(RevealPrizesJob)
  end

  it 'reveals the drawing prizes' do
    expect_any_instance_of(RevealPrizes).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
