require 'rails_helper'

RSpec.describe EndDrawingJob do
  let(:drawing) { create(:drawing) }

  subject { described_class.perform_later(drawing) }

  it 'enqueues the job' do
    expect { subject }.to enqueue_job(EndDrawingJob)
  end

  it 'ends the drawing' do
    expect_any_instance_of(EndDrawing).to receive(:call)
    perform_enqueued_jobs { subject }
  end
end
