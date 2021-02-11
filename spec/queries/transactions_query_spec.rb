require 'rails_helper'

RSpec.describe TransactionsQuery do
  let(:player) { create(:player) }
  let(:params) { { page: 1, per_page: 3 } }

  let!(:payments) { create_list(:payment, 2, player: player, amount: -2.0) }
  let!(:deposit) { create(:deposit, player: player, amount: 10.0) }

  let!(:pending_deposit) do
    create(:deposit, player: player, amount: 20.0, status: 'pending')
  end

  subject { described_class.new(player, params) }

  it 'returns transactions' do
    expect(subject.call).to include(deposit, payments[1], pending_deposit)
  end

  it 'sorts transactions' do
    expect(subject.call).to eq([pending_deposit, deposit, payments[1]])
  end

  it 'paginates transactions' do
    result = subject.call

    expect(result.count).to eq(3)
    expect(result).not_to include(payments[0])
  end

  context 'when the transaction is cancelled' do
    before { deposit.update!(status: 'cancelled') }

    it 'does not return cancelled transactions' do
      expect(subject.call).not_to include(deposit)
    end
  end
end
