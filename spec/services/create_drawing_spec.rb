require 'rails_helper'

RSpec.describe CreateDrawing do
  let(:lottery) { create(:predrawn_lottery) }

  subject { described_class.new(lottery) }

  it 'creates a drawing' do
    result = subject.call

    expect(result).to be_a(Drawing)

    expect(result.name).to eq("#{lottery.name} ##{lottery.drawings.count}")

    expect(result.starts_at).to eq(lottery.starts_at)
    expect(result.ends_at).to eq(lottery.starts_at + lottery.repeat_every.seconds)
  end

  it 'calculates drawing start time' do
    result = subject.call

    expect(result.starts_at).to eq(lottery.starts_at)
    expect(result.ends_at).to eq(lottery.starts_at + lottery.repeat_every.seconds)
  end

  context 'when lottery has previous drawings' do
    let(:drawing) do
      create(:drawing, ends_at: lottery.starts_at + lottery.repeat_every.seconds)
    end

    before do
      lottery.drawings << drawing
    end

    it 'calculates drawing start time' do
      result = subject.call

      expect(result.starts_at).to eq(drawing.ends_at)
      expect(result.ends_at).to eq(drawing.ends_at + lottery.repeat_every.seconds)
    end
  end

  it 'copies the prizes from the lottery' do
    result = subject.call

    expect(result.prizes.count).to eq(lottery.prizes.count)

    drawing_prize = result.prizes.first
    lottery_prize = lottery.prizes.first

    expect(drawing_prize.name).to eq(lottery_prize.name)
    expect(drawing_prize.description).to eq(lottery_prize.description)
    expect(drawing_prize.value).to eq(lottery_prize.value)
    expect(drawing_prize.quantity).to eq(lottery_prize.quantity)
    expect(drawing_prize.reveal_type).to eq(lottery_prize.reveal_type)
  end
end
