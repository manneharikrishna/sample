require 'rails_helper'

RSpec.describe EntriesQuery do
  let(:player) { create(:player) }
  let(:params) { { page: 1, per_page: 2 } }

  let!(:entries) { create_list(:entry, 3, player: player) }

  subject { described_class.new(player, params) }

  it 'sorts entries by a creation date' do
    expect(subject.call).to eq([entries[2], entries[1]])
  end

  it 'paginates entries' do
    result = subject.call

    expect(result.count).to eq(2)
    expect(result).not_to include(entries[0])
  end
end
