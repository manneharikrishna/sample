require 'rails_helper'

RSpec.describe Deposits::Create, nets: true do
  let(:player) { create(:player) }
  let(:payload) do
    Deposits::ConfigurePayload.new(player, params)
  end
  let(:params) { load_json_fixture(:deposit) }

  subject { described_class.new(player, payload) }

  it 'creates a deposit' do
    result = subject.call

    expect(result).to be_a(Deposit)

    expect(result.amount).to eq(params['amount'].to_d)
    expect(result.redirect_url).to be_present
  end

  context 'with the subscription payload' do
    let(:params) { super().merge(tickets_count: 5) }
    let(:payload) do
      Deposits::ConfigureSubscriptionPayload.new(player, params)
    end

    it 'creates a deposit' do
      result = subject.call

      expect(result).to be_a(Deposit)
      expect(result.amount).to eq(params['amount'].to_d)
      expect(result.redirect_url).to be_present
    end
  end
end
