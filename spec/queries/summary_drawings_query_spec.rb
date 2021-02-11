require 'rails_helper'

RSpec.describe SummaryDrawingsQuery do
  let!(:pending_drawing) { create(:drawing) }
  let!(:ready_drawing) { create(:drawing, :ready) }
  let!(:started_drawing) { create(:drawing, :started) }
  let!(:previous_ended_drawing) { create(:drawing, :ended) }
  let!(:ended_drawing) { create(:drawing, :ended) }
  let!(:cancelled_drawing) { create(:drawing, :cancelled) }

  subject { described_class.new }

  it 'returns started and ended drawing' do
    result = subject.call

    expect(result).to include(started_drawing)
    expect(result).to include(ended_drawing)

    expect(result).not_to include(pending_drawing)
    expect(result).not_to include(ready_drawing)
    expect(result).not_to include(cancelled_drawing)
    expect(result).not_to include(previous_ended_drawing)
  end

  it 'returns exactly 2 drawings' do
    result = subject.call

    expect(result.count).to eq(2)
  end

  context 'without any drawings' do
    before { Drawing.destroy_all }

    it 'returns an empty array' do
      result = subject.call
      expect(result).to eq([])
    end
  end

  context 'without one drawings' do
    before { Drawing.in_state(:ended).destroy_all }

    it 'returns an empty array' do
      result = subject.call
      expect(result.count).to eq(1)
    end
  end
end
