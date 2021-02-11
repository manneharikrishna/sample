require 'rails_helper'

RSpec.describe WithdrawalForm do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  let(:params) { load_json_fixture(:withdrawal) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without an amount' do
    before { params.delete('amount') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['amount']).to be_present
    end
  end

  context 'with an invalid amount' do
    before { params['amount'] = -1 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['amount']).to be_present
    end
  end
end
