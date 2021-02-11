require 'rails_helper'

RSpec.describe PrepareDrawing::PredrawnStrategy do
  let(:drawing) { create(:predrawn_lottery_drawing) }

  subject { described_class.new(drawing) }

  it 'generates tickets' do
    expect_any_instance_of(GenerateTickets).to receive(:call)
    subject.call
  end

  it 'assigns prizes' do
    expect_any_instance_of(AssignPrizes).to receive(:call)
    subject.call
  end
end
