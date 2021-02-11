require 'rails_helper'

RSpec.describe CreateEntry::PredrawnStrategy do
  let(:entry) { create(:entry, drawing: drawing) }
  let(:drawing) { create(:predrawn_lottery_drawing, :with_tickets) }

  let(:params) { load_json_fixture(:entry) }

  subject { described_class.new(entry, params) }

  before do
    create(:deposit, amount: 100, player: entry.player)
  end

  it_behaves_like CreateEntry::PaidStrategy

  it 'creates a payment associated with the entry' do
    subject.call
    expect(entry.payment).to be_present
  end

  context 'when tickets are available' do
    it 'assigns tickets to the entry' do
      subject.call

      expect(drawing.tickets).to include(*entry.tickets)
      expect(entry.tickets.count).to eq(entry.tickets_count)
    end

    it 'reveals the entry' do
      expect_any_instance_of(RevealEntry).to receive(:call)
      subject.call
    end

    context 'when the entry is subscription entry type' do
      before { entry.update!(entry_type: 'subscription') }

      it 'does not reveal the entry' do
        expect_any_instance_of(RevealEntry).to_not receive(:call)
        subject.call
      end
    end
  end

  context 'when tickets are not available' do
    before { drawing.tickets.update(entry: create(:entry)) }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
