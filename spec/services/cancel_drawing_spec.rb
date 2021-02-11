require 'rails_helper'

RSpec.describe CancelDrawing do
  subject { described_class.new(drawing) }

  context 'with a started drawing' do
    let(:drawing) { create(:drawing, :started) }

    it 'cancels the drawing' do
      expect { subject.call }.to change { drawing.status }.to(:cancelled)
    end
  end

  context 'with a pending drawing' do
    let(:drawing) { create(:drawing) }

    it 'raises an error' do
      expect { subject.call }.to raise_error(Statesman::TransitionFailedError)
    end
  end
end
