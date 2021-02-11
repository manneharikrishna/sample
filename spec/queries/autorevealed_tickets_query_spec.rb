require 'rails_helper'

RSpec.describe AutorevealedTicketsQuery do
  let!(:player) { create(:player) }
  let!(:drawing) { create(:drawing) }

  let!(:tickets) do
    create_list(:ticket, 3, player: player, drawing: drawing)
  end

  subject { described_class.new(player, drawing) }

  context 'when the tickets are autorevealed' do
    let!(:ticket_autoreveals) do
      create(:ticket_autoreveal, ticket: tickets[1], ticket_type: 'weekly')
    end

    it 'reveals the autorevealed tickets' do
      expect(subject.weekly_tickets).to contain_exactly(tickets[1])
    end

    context 'when there are no autorevealed weekly tickets' do
      before { tickets[1].ticket_autoreveals.update(ticket_type: 'subscription') }

      it 'does not return any tickets' do
        expect(subject.weekly_tickets).to be_empty
      end
    end
  end

  context 'when the tickets are autorevealed' do
    let!(:ticket_autoreveals) do
      create(:ticket_autoreveal, ticket: tickets[0], ticket_type: 'subscription')
    end

    it 'returns the autorevealed subscription tickets' do
      expect(subject.subscription_tickets).to contain_exactly(tickets[0])
    end

    context 'when there are no autorevealed subscription tickets' do
      before { tickets[0].ticket_autoreveals.update(ticket_type: 'weekly') }

      it 'does not return any tickets' do
        expect(subject.subscription_tickets).to be_empty
      end
    end
  end

  context 'when the tickets are not autorevealed' do
    it 'returns an empty array' do
      expect(subject.subscription_tickets).to be_empty
      expect(subject.weekly_tickets).to be_empty
    end
  end
end
