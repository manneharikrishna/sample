require 'rails_helper'

RSpec.describe StartLotteryJob do
  let(:lottery) { create(:lottery, :ready) }

  subject { described_class.perform_later(lottery) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(StartLotteryJob)
  end

  it 'starts the lottery' do
    expect_any_instance_of(StartLottery).to receive(:call)
    perform_enqueued_jobs { subject }
  end

  context 'when the lottery is not ready' do
    let(:lottery) { create(:lottery, :final) }

    it 'does not start the lottery' do
      expect_any_instance_of(StartLottery).not_to receive(:call)
      perform_enqueued_jobs { subject }
    end
  end
end
