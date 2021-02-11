require 'rails_helper'

RSpec.describe PrepareLotteryJob do
  let(:lottery) { create(:lottery) }

  subject { described_class.perform_later(lottery) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(PrepareLotteryJob)
  end

  it 'prepares the lottery' do
    expect_any_instance_of(PrepareLottery).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
