require 'rails_helper'
require 'savon/mock/spec_helper'

RSpec.describe CreateWithdrawal, email: true, mixpanel: true do
  let(:player) { create(:player) }
  let(:amount) { 299.99 }

  subject { described_class.new(player, amount) }

  it 'creates a withdrawal' do
    result = subject.call

    expect(result).to be_a(Withdrawal)
    expect(result.amount).to eq(-amount.to_d)
  end

  it 'sends a bank transfer email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end

  it 'schedules wallet balance tracking' do
    expect { subject.call }.to enqueue_job(TrackWalletBalanceJob)
  end
end
