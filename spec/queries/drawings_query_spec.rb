require 'rails_helper'

RSpec.describe DrawingsQuery do
  let!(:pending_drawing) { create(:drawing) }
  let!(:ready_drawing) { create(:drawing, :ready) }
  let!(:started_drawing) { create(:drawing, :started) }
  let!(:ended_drawing) { create(:drawing, :ended) }
  let!(:cancelled_drawing) { create(:drawing, :cancelled) }

  subject { described_class.new }

  it 'returns started drawings' do
    result = subject.call

    expect(result).to include(started_drawing)

    expect(result).not_to include(pending_drawing)
    expect(result).not_to include(ready_drawing)
    expect(result).not_to include(ended_drawing)
    expect(result).not_to include(cancelled_drawing)
  end
end
