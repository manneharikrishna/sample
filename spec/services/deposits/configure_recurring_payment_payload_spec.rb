require 'rails_helper'

RSpec.describe Deposits::ConfigureRecurringPaymentPayload, nets: true do
  let(:player) { create(:player) }
  let(:params) { { amount: 100, nets_token: 'XvmOaZdTrK7XL2ILTpICz8wM/pM=' } }
  let(:deposit) { create(:deposit, player: player, amount: params[:amount]) }

  subject { described_class.new(player, params).call(deposit) }

  it 'configures a deposit payload' do
    result = subject.configure
    language = Nets::Config.new.languages[player.language.to_sym]

    expect(result['currency_code']).to be_present
    expect(result['payment_method_action_list']).to be_present
    expect(result['language']).to eq(language)
    expect(result['order_number']).to eq(deposit.id)
    expect(result['amount']).to eq(params[:amount].to_i * 100)
    expect(result['pan_hash']).to be_present
    expect(result['recurring_type']).to be_present
    expect(result['service_type']).to be_present
  end
end
