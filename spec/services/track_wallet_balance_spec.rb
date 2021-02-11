require 'rails_helper'

RSpec.describe TrackWalletBalance, mixpanel: true do
  let(:player) { create(:player) }
  let(:balance) { CalculateBalance.new(player).call }

  before do
    create(:deposit, amount: 20, player: player)
    create(:payment, amount: -5, player: player)
  end

  subject { described_class.new(player, balance) }

  let(:payload) { { 'Wallet Balance' => 15 } }

  it 'registers the wallet balance in analytics' do
    expect(RegisterInAnalytics).to receive(:new).with(player, :set, payload).
      and_call_original

    expect_any_instance_of(RegisterInAnalytics).to receive(:call)

    subject.call
  end
end
