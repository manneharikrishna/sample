require 'rails_helper'

RSpec.describe CreateAward do
  let(:entry) { create(:entry) }

  let!(:ticket) { create(:ticket, entry: entry, prize: prize) }
  let!(:prize) { create(:prize) }

  let(:balance_limit) { ENV.fetch('BALANCE_LIMIT').to_i }

  subject { described_class.new(entry, prize) }

  it 'creates an award transaction' do
    subject.call
    expect(entry.player.transactions).to include(Award)
  end

  it 'schedules wallet balance tracking' do
    expect { subject.call }.to enqueue_job(TrackWalletBalanceJob)
  end

  context 'when the balance exceeds the limit' do
    let!(:prize) { create(:prize, value: value) }
    let(:value) { balance_limit + 100 }

    it 'creates an automatic withdrawal' do
      expect_any_instance_of(CreateAutomaticWithdrawal).to receive(:call)
      subject.call
    end

    it 'creates a withdrawal' do
      expect { subject.call }.to change { Withdrawal.count }
    end
  end

  context 'when the balance equals the limit' do
    let!(:prize) { create(:prize, value: balance_limit) }

    it "doesn't create a withdrawal" do
      expect { subject.call }.not_to change { Withdrawal.count }
    end
  end

  context "when the balance doesn't exceed the limit" do
    let!(:prize) { create(:prize, value: 200) }
    let!(:deposit) { create(:deposit, player: entry.player, amount: amount) }

    let(:amount) { balance_limit - 300 }

    it "doesn't create a withdrawal" do
      expect { subject.call }.not_to change { Withdrawal.count }
    end
  end
end
