require 'rails_helper'

RSpec.describe PrepareDrawingJob do
  let(:drawing) { create(:drawing) }

  subject { described_class.perform_later(drawing) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(PrepareDrawingJob)
  end

  it 'prepares the drawing' do
    expect_any_instance_of(PrepareDrawing).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
