require 'rails_helper'

RSpec.describe LossLimitsForm do
  let(:player) { create(:player) }

  subject { described_class.new(player, params) }

  let(:params) { load_json_fixture(:loss_limits) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a weekly loss limit' do
    before { params.delete('weekly_loss_limit') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['weekly_loss_limit']).to be_present
    end
  end

  context 'when the daily loss limit exceeds the weekly loss limit' do
    before { params['daily_loss_limit'] = params['weekly_loss_limit'] + 100 }

    it 'fails the validation' do
      expect(subject.validate(params)).to be(false)
      expect(subject.errors[:daily_loss_limit]).to be_present
    end
  end

  context 'when the weekly loss limit is not greater than zero' do
    before { params['weekly_loss_limit'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['weekly_loss_limit']).to be_present
    end
  end

  context 'when the weekly loss limit exceeds the default' do
    let(:weekly_loss_limit) { Limits.weekly_loss_limit }

    before { params['weekly_loss_limit'] = weekly_loss_limit + 100 }

    it 'fails the validation' do
      expect(subject.validate(params)).to be(false)
      expect(subject.errors[:weekly_loss_limit]).to be_present
    end
  end

  context 'without a daily loss limit' do
    before { params.delete('daily_loss_limit') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['daily_loss_limit']).to be_present
    end
  end

  context 'when the daily loss limit is not greater than zero' do
    before { params['daily_loss_limit'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['daily_loss_limit']).to be_present
    end
  end

  context 'when the daily loss limit exceeds the default' do
    let(:daily_loss_limit) { Limits.daily_loss_limit }

    before { params['daily_loss_limit'] = daily_loss_limit + 100 }

    it 'fails the validation' do
      expect(subject.validate(params)).to be(false)
      expect(subject.errors[:daily_loss_limit]).to be_present
    end
  end
end
