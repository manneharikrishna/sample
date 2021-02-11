require 'rails_helper'

RSpec.describe Admin::LotteryForm do
  let(:lottery) { create(:lottery, :social) }

  subject { described_class.new(lottery) }

  let(:params) { load_json_fixture(:lottery) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an empty name' do
    before { params['name'] = '' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end

  context 'when the headline is too long' do
    before { params['headline'] = Faker::Lorem.characters(101) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['headline']).to be_present
    end
  end

  context 'with an empty start time' do
    before { params['starts_at'] = '' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['starts_at']).to be_present
    end
  end

  context 'with an invalid start time' do
    before { params['starts_at'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['starts_at']).to be_present
    end
  end

  context 'when the start time is in the past' do
    before { params['starts_at'] = '2016-10-25T00:00:00.000Z' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['starts_at']).to be_present
    end
  end

  context 'with an empty end time' do
    before { params['ends_at'] = '' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ends_at']).to be_present
    end
  end

  context 'with an invalid end time' do
    before { params['ends_at'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ends_at']).to be_present
    end
  end

  context 'when the end time precedes the start time' do
    before { params['ends_at'] = '2016-10-24T00:00:00.000Z' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ends_at']).to be_present
    end
  end

  context 'when the duration falls below the limit' do
    before { params['repeat_every'] = '10000' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['duration']).to be_present
    end
  end

  context 'when the duration exceeds the limit' do
    before { params['repeat_every'] = '2678400' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['duration']).to be_present
    end
  end

  context 'without the repetition' do
    before do
      lottery.update(repeat_every: nil)
      params.delete('repeat_every')
    end

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['repeat_every']).to be_present
    end
  end

  context 'when the repetition is equal to 0' do
    before { params['repeat_every'] = '0' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['repeat_every']).to be_present
    end
  end

  context 'when the repetition is invalid' do
    before { params['repeat_every'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['repeat_every']).to be_present
    end
  end

  context 'when the repetition exceeds the lottery duration' do
    let(:lottery_duration) { lottery.ends_at.to_i - lottery.starts_at.to_i }

    before { params['repeat_every'] = lottery_duration + 1 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['repeat_every']).to be_present
    end
  end

  context 'with final parameters' do
    before { params['final'] = 'true' }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
      expect { subject.save }.to change { subject.model.status }
    end
  end
end
