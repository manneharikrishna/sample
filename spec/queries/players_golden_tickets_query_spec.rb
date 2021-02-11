require 'rails_helper'

RSpec.describe PlayersGoldenTicketsQuery do
  let!(:drawing) { create(:drawing) }
  let!(:prize) { create(:prize, :weekly) }

  let!(:tickets_with_prize) { create_list(:ticket, 2, drawing: drawing, prize: prize) }
  let!(:tickets) { create_list(:ticket, 3, drawing: drawing, prize: nil) }

  subject { described_class.new(drawing) }

  it 'returns a list of players with golden tickets' do
    expect(subject.call).not_to be_empty
    expect(subject.call).to include(tickets[0].entry.player)
  end

  it "contains the number of player's golden tickets" do
    expect(subject.call[0]['golden_tickets']).to eq(1)
  end

  context 'when player had their tickets already revealed' do
    before { tickets[0].reveal }

    it 'does not return them' do
      expect(subject.call).not_to include(tickets[0].entry.player)
    end
  end
end
