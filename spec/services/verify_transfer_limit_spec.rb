require 'rails_helper'

RSpec.describe VerifyTransferLimit do
  subject { described_class.new(amount) }

  context 'when the amount is above the transfer limit' do
    let(:amount) { 11 }

    it "doesn't raise an error" do
      expect { subject.call }.not_to raise_error
    end
  end

  context 'when the amount is equal to the transfer limit' do
    let(:amount) { Limits.transfer_limit }

    it "doesn't raise an error" do
      expect { subject.call }.not_to raise_error
    end
  end

  context 'when the amount falls below the transfer limit' do
    let(:amount) { 9 }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
