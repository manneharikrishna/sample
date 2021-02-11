require 'rails_helper'

RSpec.describe FinalizeLottery do
  let(:lottery) { create(:predrawn_lottery) }

  subject { described_class.new(lottery.reload) }

  it 'updates the lottery status' do
    expect { subject.call }.to change { lottery.status }.to(:final)
  end

  it 'schedules the lottery preparation' do
    expect { subject.call }.to enqueue_job(PrepareLotteryJob)
  end
end
