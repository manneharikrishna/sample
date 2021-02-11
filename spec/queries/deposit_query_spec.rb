require 'rails_helper'

RSpec.describe DepositQuery do
  let!(:nets_payment_id) { 'bc441001e7a74c6caf4332f8a064aea1' }
  let!(:deposit) { create(:deposit, nets_payment_id: nets_payment_id) }

  subject { described_class.new(nets_payment_id) }

  it 'returns the deposit' do
    expect(subject.call).to eq(deposit)
  end
end
