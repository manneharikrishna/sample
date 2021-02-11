require 'rails_helper'

RSpec.describe StartDrawing do
  let(:drawing) { create(:drawing, :ready) }

  subject { described_class.new(drawing) }

  it 'updates the drawing status' do
    expect { subject.call }.to change { drawing.status }.to(:started)
  end

  it 'schedules the drawing end' do
    expect { subject.call }.to enqueue_job(EndDrawingJob)
  end

  context 'with subscribers' do
    before { create(:subscription, :active) }

    it 'subscribe the drawing' do
      expect { subject.call }.to enqueue_job(SubscribeDrawingJob)
    end
  end
end
