require 'rails_helper'

RSpec.describe PrepareLottery do
  let(:lottery) { create(:lottery, :final) }

  subject { described_class.new(lottery) }

  it 'creates a drawing' do
    expect_any_instance_of(CreateDrawing).to receive(:call)
    subject.call
  end

  it 'schedules the drawing preparation' do
    expect { subject.call }.to enqueue_job(PrepareDrawingJob)
  end

  it 'schedules the lottery start' do
    expect { subject.call }.to enqueue_job(StartLotteryJob)
  end

  it 'updates the lottery status' do
    expect { subject.call }.to change { lottery.status }.to(:ready)
  end
end
