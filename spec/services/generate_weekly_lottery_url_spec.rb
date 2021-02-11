require 'rails_helper'

RSpec.describe GenerateWeeklyLotteryUrl do
  let(:redirect_url) { ENV['WEEKLY_LOTTERY_REDIRECT_URL'] }
  let(:drawing) { create(:drawing, tickets_count: 100) }

  subject { described_class.new(drawing).call }

  it 'generates a weekly lottery url' do
    expected_url = "#{redirect_url}?lid=#{drawing.id}"
    expect(subject).to eq(expected_url)
  end
end
