require 'rails_helper'

RSpec.describe Admin::PoolPrizePoolForm do
  let(:lottery) { create(:lottery, :pool) }

  subject { described_class.new(lottery) }

  let(:params) { load_json_fixture(:pool_prize_pool) }

  it_behaves_like Admin::PrizePoolForm

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a payback ratio' do
    before { params.delete('payback_ratio') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end

  context 'with an invalid payback ratio' do
    before { params['payback_ratio'] = 101 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end

  context 'when the payback ratio exceeds the limit' do
    before { params['payback_ratio'] = 91 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end

  context 'when the payback ratio falls below the limit' do
    before { params['payback_ratio'] = 9 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end
end
