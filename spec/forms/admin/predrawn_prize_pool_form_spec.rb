require 'rails_helper'

RSpec.describe Admin::PredrawnPrizePoolForm do
  let(:lottery) { create(:lottery) }

  subject { described_class.new(lottery) }

  let(:params) { load_json_fixture(:predrawn_prize_pool) }

  it_behaves_like Admin::PrizePoolForm

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without prizes' do
    before { params.delete('prizes') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['prizes']).to be_present
    end
  end

  context 'with a prize' do
    context 'without a name' do
      before { params['prizes'][0].delete('name') }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.name']).to be_present
      end
    end

    context 'without a value' do
      before { params['prizes'][0].delete('value') }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.value']).to be_present
      end
    end

    context 'with an invalid value' do
      before { params['prizes'][0]['value'] = -1 }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.value']).to be_present
      end
    end

    context 'without a quantity' do
      before { params['prizes'][0].delete('quantity') }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.quantity']).to be_present
      end
    end

    context 'with an invalid quantity' do
      before { params['prizes'][0]['quantity'] = -1 }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.quantity']).to be_present
      end
    end

    context 'with an invalid reveal type' do
      before { params['prizes'][0]['reveal_type'] = 'invalid' }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['prizes.reveal_type']).to be_present
      end
    end

    context 'with an empty reveal type' do
      before { params['prizes'][0]['reveal_type'] = '' }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
      end
    end
  end

  context 'when the tickets count has been exceeded' do
    before { params['prizes'][0]['quantity'] = 101 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['base']).to be_present
    end
  end

  context 'when the total revenue has been exceeded' do
    before { params['prizes'][0]['value'] = 1001 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['base']).to be_present
    end
  end

  context 'when the payback ratio exceeds the limit' do
    before { params['prizes'][0]['quantity'] = 100 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end

  context 'when the payback ratio falls below the limit' do
    before { params['prizes'][0]['quantity'] = 10 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['payback_ratio']).to be_present
    end
  end
end
