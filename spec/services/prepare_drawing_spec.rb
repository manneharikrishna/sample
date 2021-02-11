require 'rails_helper'

RSpec.describe PrepareDrawing do
  let(:drawing) { create(:drawing, :pending, lottery: lottery) }
  let(:lottery) { create(:lottery, :pool, :final) }

  subject { described_class.new(drawing) }

  it 'updates the drawing status' do
    expect { subject.call }.to change { drawing.status }.to(:ready)
  end

  it 'schedules the drawing start' do
    expect { subject.call }.to enqueue_job(StartDrawingJob)
  end

  it 'schedules the prize reveal' do
    expect { subject.call }.to enqueue_job(RevealPrizesJob)
  end
end
