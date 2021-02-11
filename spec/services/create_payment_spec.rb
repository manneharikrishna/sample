require 'rails_helper'

RSpec.describe CreatePayment do
  let(:entry) { create(:entry) }

  let(:amount) { 100 }

  subject { described_class.new(entry, amount) }

  it 'creates a payment transaction' do
    subject.call
    expect(entry.player.transactions).to include(Payment)
  end

  it 'returns a payment transaction' do
    expect(subject.call).to be_a(Payment)
  end

  it 'assigns a negative amount' do
    expect(subject.call.amount).to be < 0
  end

  it 'schedules wallet balance tracking' do
    expect { subject.call }.to enqueue_job(TrackWalletBalanceJob)
  end
end
