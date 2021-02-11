require 'rails_helper'

RSpec.describe RepeatDrawing do
  let(:lottery) { create(:lottery) }

  subject { described_class.new(lottery) }

  it 'creates next drawing' do
    expect { subject.call }.to change { Drawing.count }.from(0).to(1)
  end

  it 'schedules next drawing preparation' do
    expect { subject.call }.to enqueue_job(PrepareDrawingJob)
  end
end
