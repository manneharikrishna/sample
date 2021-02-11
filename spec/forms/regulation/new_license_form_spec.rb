require 'rails_helper'

RSpec.describe Regulation::NewLicenseForm do
  subject { described_class.new(License.new) }

  let(:params) { load_json_fixture(:license) }

  it_behaves_like Regulation::LicenseForm

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a lottery type' do
    before { params.delete('lottery_type') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['lottery_type']).to be_present
    end
  end

  context 'with an invalid lottery type' do
    before { params['lottery_type'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['lottery_type']).to be_present
    end
  end
end
