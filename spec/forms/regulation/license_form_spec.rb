require 'rails_helper'

RSpec.describe Regulation::LicenseForm do
  let(:license) { License.new }

  subject { described_class.new(license) }

  let(:params) { load_json_fixture(:license) }

  it_behaves_like Regulation::LicenseForm

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end
end
