require 'rails_helper'

RSpec.describe Admin::PrizePayoutQuery do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(weekly_prize) }

  context "when the drawing hasn't ended" do
    it 'returns nothing' do
      expect(subject.call).to be_nil
    end
  end

  context 'when the drawing has ended' do
    before { drawing.update!(ends_at: 1.day.ago) }

    it 'returns the prize payout' do
      expect(subject.call.to_d).to eq(1000)
    end
  end
end
