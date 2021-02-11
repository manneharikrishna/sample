require 'rails_helper'

RSpec.describe StartDrawingJob do
  let(:drawing) { create(:drawing) }

  subject { described_class.perform_later(drawing) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(StartDrawingJob)
  end

  it 'starts the drawing' do
    expect_any_instance_of(StartDrawing).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
