require 'rails_helper'

RSpec.describe LotteriesQuery do
  let!(:lotteries) do
    [
      create(:lottery, ends_at: 1.day.from_now),
      create(:lottery, ends_at: 2.days.from_now)
    ]
  end

  subject { described_class.new }

  it 'returns all lotteries' do
    expect(subject.call).to match_array(lotteries)
  end

  it 'sorts lotteries by a end time' do
    expect(subject.call).to eq([lotteries[1], lotteries[0]])
  end
end
