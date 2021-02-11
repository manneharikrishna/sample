require 'rails_helper'

RSpec.describe CalculateDrawingStart do
  let(:lottery) { create(:predrawn_lottery) }

  subject { described_class.new(lottery) }

  it 'calculates next drawing start time' do
    result = subject.call
    expect(result).to eq(lottery.starts_at)
  end

  context 'when lottery has previous drawings' do
    let(:drawing) do
      create(:drawing, ends_at: lottery.starts_at + lottery.repeat_every.seconds)
    end

    before { lottery.drawings << drawing }

    it 'calculates next drawing start time' do
      result = subject.call
      expect(result).to eq(drawing.ends_at)
    end
  end
end
