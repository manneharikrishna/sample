require 'rails_helper'

RSpec.describe DrawingTicketsQuery do
  let!(:player) { create(:player) }

  include_context 'a drawing with sold tickets' do
    let!(:entries) { create_list(:entry, 3, drawing: drawing, player: player) }
  end

  subject { described_class.new(player, drawing) }

  context 'when the entry is revealed' do
    before { entries.each(&:reveal) }

    it 'returns unrevealed tickets' do
      expect(subject.call).to contain_exactly(tickets[1], tickets[3])
    end
  end

  context 'when the entry is not revealed' do
    it "doesn't return the tickets" do
      expect(subject.call).to eq([])
    end
  end

  context 'when a ticket is already revealed' do
    before { tickets[1].reveal }

    it "doesn't return the ticket" do
      expect(subject.call).not_to include(tickets[1])
    end
  end
end
