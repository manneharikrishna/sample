require 'rails_helper'

RSpec.describe VerifyTransaction, nets: true do
  let(:deposit) { create(:deposit, status: 'pending') }

  subject { described_class.new(deposit) }

  context 'without a subscription presence' do
    it 'verifies the deposit' do
      expect_any_instance_of(Deposits::Verify).to receive(:call)
      subject.call
    end
  end

  context 'with a subscription presence' do
    let(:deposit) { create(:deposit, status: 'pending', subscription: subscription) }
    let(:subscription) { create(:subscription) }

    it 'verifies the subscription deposit' do
      expect_any_instance_of(VerifySubscription).to receive(:call)
      subject.call
    end
  end
end
