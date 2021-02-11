require 'rails_helper'

RSpec.describe CreateAutomaticWithdrawal, email: true do
  let(:player) { create(:player) }
  let(:prize) { create(:prize, value: value) }

  let(:balance_limit) { Limits.balance_limit }
  let(:value) { balance_limit + 100 }

  before do
    create(:award, player: player, amount: prize.value)
  end

  subject { described_class.new(player, prize) }

  it 'creates a withdrawal' do
    expect(subject.call).to be_a(Withdrawal)
  end

  context 'without a bank account number' do
    before { player.bank_account_number = nil }

    it "doesn't create a withdrawal" do
      expect { subject.call }.not_to change { Withdrawal.count }
    end

    it 'sends a missing bank account number email' do
      perform_enqueued_jobs do
        expect { subject.call }.to change { deliveries.count }.by(1)
      end
    end

    context "when the balance doesn't exceed the limit" do
      let(:value) { balance_limit }

      it "doesn't send a missing bank account number email" do
        perform_enqueued_jobs do
          expect { subject.call }.not_to change { deliveries.count }
        end
      end
    end
  end

  context "when the balance doesn't exceed the limit" do
    let(:value) { balance_limit }

    it "doesn't create a withdrawal" do
      expect { subject.call }.not_to change { Withdrawal.count }
    end

    it "doesn't send a missing bank account number email" do
      perform_enqueued_jobs do
        expect { subject.call }.not_to change { deliveries.count }
      end
    end
  end
end
