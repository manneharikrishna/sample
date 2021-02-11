require 'rails_helper'

RSpec.describe CreateWinning do
  let(:drawing) { create(:pool_lottery_drawing) }

  subject { described_class.new(drawing) }

  it 'creates a drawing winning' do
    result = subject.call

    expect(result).to be_a(Winning)
    expect(result.winner).to be_a(Player)

    expect(drawing.players).to include(result.winner)
  end
end
