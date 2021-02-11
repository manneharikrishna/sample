require 'rails_helper'

RSpec.describe CalculatePrizePayoutRatio do
  let(:prize_payout) { 100 }
  let(:total_turn_over) { 200 }

  subject { described_class.new(prize_payout, total_turn_over) }

  it 'returns the prize payout ratio' do
    expect(subject.call).to eq(50)
  end

  context 'when the total turn over is zero' do
    let(:total_turn_over) { 0 }

    it 'returns zero' do
      expect(subject.call).to eq(0)
    end
  end
end
