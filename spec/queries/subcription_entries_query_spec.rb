require 'rails_helper'

RSpec.describe SubscriptionEntriesQuery do
  let(:player) { create(:player) }
  let(:drawing) { create(:drawing) }

  let!(:subscription_entries) do
    create_list(:entry, 2, player: player, entry_type: 'subscription', drawing: drawing)
  end
  let!(:entries) { create_list(:entry, 3, player: player, drawing: drawing) }

  subject { described_class.new(player, drawing) }

  it 'returns subscription entries' do
    expect(subject.call).to eq(subscription_entries.reverse)
  end

  it 'sorts entries by a creation date' do
    expect(subject.call).to eq([subscription_entries[1], subscription_entries[0]])
  end

  context 'with revealed entries' do
    before { subscription_entries.each(&:reveal) }

    it 'returns nothing' do
      expect(subject.call).to eq([])
    end
  end
end
