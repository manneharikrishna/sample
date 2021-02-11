require 'rails_helper'

RSpec.describe Admin::WinningTicketsCountQuery do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing) }

  context "when the drawing hasn't ended" do
    it 'returns the winning tickets count' do
      expect(subject.call).to eq(1)
    end
  end

  context 'when the drawing has ended' do
    before { drawing.update!(ends_at: 1.day.ago) }

    it 'returns the winning tickets count' do
      expect(subject.call).to eq(2)
    end
  end
end
