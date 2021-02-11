require 'rails_helper'

RSpec.describe TrackWalletBalanceJob do
  let(:player) { create(:player) }
  let(:balance) { 20 }

  subject { described_class.perform_later(player, balance) }

  it_behaves_like RetryableJob

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(TrackWalletBalanceJob)
  end

  it 'tracks a wallet balance' do
    expect_any_instance_of(TrackWalletBalance).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
