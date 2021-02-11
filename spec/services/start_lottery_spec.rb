require 'rails_helper'

RSpec.describe StartLottery do
  let(:lottery) { create(:lottery, :ready) }

  subject { described_class.new(lottery) }

  it 'updates the lottery status' do
    expect { subject.call }.to change { lottery.status }.to(:started)
  end

  it 'schedules the lottery end' do
    expect { subject.call }.to enqueue_job(EndLotteryJob)
  end
end
