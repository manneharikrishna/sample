require 'rails_helper'

RSpec.describe CalculatePaybackRatio do
  let(:prize_pool_form) { Admin::PredrawnPrizePoolForm.new(lottery) }
  let(:lottery) { create(:predrawn_lottery) }

  subject { described_class.new(prize_pool_form) }

  it 'returns the payback ratio' do
    expect(subject.call).to eq(100)
  end

  context 'without prizes' do
    before { lottery.prizes.clear }

    it 'returns nothing' do
      expect(subject.call).to eq(nil)
    end
  end

  context 'without a ticket price' do
    before { lottery.ticket_price = nil }

    it 'returns nothing' do
      expect(subject.call).to eq(nil)
    end
  end

  context 'without a tickets count' do
    before { lottery.tickets_count = nil }

    it 'returns nothing' do
      expect(subject.call).to eq(nil)
    end
  end
end
