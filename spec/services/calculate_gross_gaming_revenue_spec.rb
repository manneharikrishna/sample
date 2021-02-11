require 'rails_helper'

RSpec.describe CalculateGrossGamingRevenue do
  let(:total_turn_over) { 25 }

  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing, total_turn_over) }

  context "when the drawing hasn't ended" do
    it 'returns the gross gaming revenue' do
      expect(subject.call).to eq(15)
    end
  end

  context 'when the drawing has ended' do
    before { drawing.update!(ends_at: 1.day.ago) }

    it 'returns the gross gaming revenue' do
      expect(subject.call).to eq(-985)
    end
  end
end
