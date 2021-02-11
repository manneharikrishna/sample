require 'rails_helper'

RSpec.describe EndLotteryJob do
  let(:lottery) { create(:lottery) }

  subject { described_class.perform_later(lottery) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(EndLotteryJob)
  end

  it 'ends the lottery' do
    expect_any_instance_of(EndLottery).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
