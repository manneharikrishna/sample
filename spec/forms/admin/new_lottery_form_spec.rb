require 'rails_helper'

RSpec.describe Admin::NewLotteryForm do
  let(:owner) { create(:user) }

  let(:lottery) { license.lotteries.build }
  let(:license) { create(:license) }

  subject { described_class.new(lottery) }

  let(:params) { load_json_fixture(:new_lottery) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a license' do
    before { lottery.license = nil }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['license']).to be_present
    end
  end

  context 'without a name' do
    before { params.delete('name') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end
end
