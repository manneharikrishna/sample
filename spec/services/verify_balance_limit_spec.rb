require 'rails_helper'

RSpec.describe VerifyBalanceLimit do
  let(:player) { create(:player) }

  subject { described_class.new(amount, player) }

  before do
    create(:deposit, amount: 100, player: player)
  end

  context 'with an amount not exceeding the balance' do
    let(:amount) { 5 }

    it "doesn't raise an error" do
      expect { subject.call }.not_to raise_error
    end
  end

  context 'with an amount exceeding the balance' do
    let(:amount) { Limits.balance_limit }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
