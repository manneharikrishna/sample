require 'rails_helper'

RSpec.describe CalculateBalance do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  before do
    create(:deposit, amount: 20, player: player)
    create(:payment, amount: -5, player: player)
  end

  it 'returns the balance' do
    expect(subject.call).to eq(15)
  end

  context 'when there are pending transactions' do
    before { create(:deposit, amount: 20, player: player, status: 'pending') }

    it "doesn't include pending transactions" do
      expect(subject.call).to eq(15)
    end
  end
end
