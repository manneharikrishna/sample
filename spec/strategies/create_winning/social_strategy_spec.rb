require 'rails_helper'

RSpec.describe CreateWinning::SocialStrategy do
  let(:drawing) { create(:social_lottery_drawing) }

  subject { described_class.new(drawing, ticket) }

  context 'with a ticket' do
    let(:ticket) { create(:ticket, entry: entry) }

    context 'with an approved entry' do
      let(:entry) { drawing.entries.approved.take }

      it 'draws the selected ticket' do
        expect(subject.call).to eq(ticket)
      end
    end

    context 'with a rejected entry' do
      let(:entry) { drawing.entries.rejected.take }

      it 'draws a random ticket' do
        result = subject.call

        expect(drawing.tickets).to include(result)
        expect(result.entry.status).to eq('approved')
      end
    end
  end

  context 'without a ticket' do
    let(:ticket) { nil }

    it 'draws a random ticket' do
      result = subject.call

      expect(drawing.tickets).to include(result)
      expect(result.entry.status).to eq('approved')
    end
  end
end
