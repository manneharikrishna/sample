require 'rails_helper'

RSpec.describe Deposits::Verify, nets: true do
  let(:deposit) { create(:deposit, amount: 100, status: 'pending') }

  subject { described_class.new(deposit) }

  it 'updates the deposit status' do
    subject.call
    expect(deposit.status).to eq('completed')
  end

  it 'schedules wallet balance tracking' do
    expect { subject.call }.to enqueue_job(TrackWalletBalanceJob)
  end

  context 'when the payment is not authorized' do
    context 'when the payment is cancelled' do
      before { deposit.update!(nets_payment_id: 'unauthorized-cancelled') }

      it 'updates the deposit status' do
        expect { subject.call }.to change { deposit.status }.to('cancelled')
      end
    end

    context 'when the payment is failed' do
      before { deposit.update!(nets_payment_id: 'unauthorized-failed') }

      it 'updates the deposit status' do
        expect { subject.call }.to change { deposit.status }.to('failed')
      end
    end
  end
end
