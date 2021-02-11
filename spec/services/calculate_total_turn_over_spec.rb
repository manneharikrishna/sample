require 'rails_helper'

RSpec.describe CalculateTotalTurnOver do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing) }

  it 'returns the total turn over' do
    expect(subject.call).to eq(75)
  end
end
