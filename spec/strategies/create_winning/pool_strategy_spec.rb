require 'rails_helper'

RSpec.describe CreateWinning::PoolStrategy do
  let(:drawing) { create(:pool_lottery_drawing) }

  subject { described_class.new(drawing, nil) }

  it 'draws a random ticket' do
    expect(drawing.tickets).to include(subject.call)
  end
end
