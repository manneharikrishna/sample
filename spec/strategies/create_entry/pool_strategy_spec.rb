require 'rails_helper'

RSpec.describe CreateEntry::PoolStrategy do
  let(:entry) { create(:entry, drawing: drawing) }
  let(:drawing) { create(:pool_lottery_drawing) }

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

  it 'creates tickets associated with the entry' do
    subject.call
    expect(entry.tickets.count).to eq(entry.tickets_count)
  end
end
