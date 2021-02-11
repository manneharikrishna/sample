require 'rails_helper'

RSpec.describe Deposits::ConfigurePayload, nets: true do
  let(:player) { create(:player) }
  let(:params) { load_json_fixture(:deposit) }
  let(:deposit) { create(:deposit, player: player, amount: params['amount']) }

  subject { described_class.new(player, params).call(deposit) }

  it 'configures a deposit payload' do
    result = subject.configure
    language = Nets::Config.new.languages[player.language.to_sym]

    expect(result['currency_code']).to be_present
    expect(result['payment_method_action_list']).to be_present
    expect(result['language']).to eq(language)
    expect(result['redirect_url']).to be_present
    expect(result['order_number']).to eq(deposit.id)
    expect(result['amount']).to eq(params['amount'].to_i * 100)
  end
end
