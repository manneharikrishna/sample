require 'rails_helper'

RSpec.describe Regulation::LotteriesQuery do
  let!(:pending_lottery) { create(:lottery) }
  let!(:final_lottery) { create(:lottery, :final) }
  let!(:ready_lottery) { create(:lottery, :ready, ends_at: 3.weeks.from_now) }
  let!(:started_lottery) { create(:lottery, :started, ends_at: 2.weeks.from_now) }
  let!(:ended_lottery) { create(:lottery, :ended, ends_at: 1.week.ago) }

  subject { described_class.new }

  it 'returns lotteries' do
    result = subject.call

    expect(result).to include(ready_lottery)
    expect(result).to include(started_lottery)
    expect(result).to include(ended_lottery)

    expect(result).not_to include(pending_lottery)
    expect(result).not_to include(final_lottery)
  end

  it 'sorts lotteries by an end time' do
    result = subject.call

    expect(result[0]).to eq(ready_lottery)
    expect(result[1]).to eq(started_lottery)
    expect(result[2]).to eq(ended_lottery)
  end
end
