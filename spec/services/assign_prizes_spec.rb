require 'rails_helper'

RSpec.describe AssignPrizes do
  let(:drawing) { create(:drawing, :with_tickets, tickets_count: 100) }

  let!(:prizes) do
    [
      create(:prize, prizeable: drawing, quantity: 1),
      create(:prize, prizeable: drawing, quantity: 4),
      create(:prize, prizeable: drawing, quantity: 20)
    ]
  end

  subject { described_class.new(drawing) }

  it 'assigns prizes to random drawing tickets' do
    subject.call

    expect(prizes.first.tickets.count).to eq(1)
    expect(prizes.second.tickets.count).to eq(4)
    expect(prizes.third.tickets.count).to eq(20)

    expect(drawing.tickets.winning.count).to eq(25)
    expect(drawing.tickets.non_winning.count).to eq(75)
  end
end
