require 'rails_helper'

RSpec.describe Admin::TotalPrizePayoutQuery do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing) }

  context "when the drawing hasn't ended" do
    it 'returns the total prize payout' do
      expect(subject.call.to_d).to eq(10)
    end
  end

  context 'when the drawing has ended' do
    before { drawing.update!(ends_at: 1.day.ago) }

    it 'returns the total prize payout' do
      expect(subject.call.to_d).to eq(1010)
    end
  end
end
