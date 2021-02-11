require 'rails_helper'

RSpec.describe SuspensionForm do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  let(:params) { { suspended_until: 1.month.from_now } }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a suspension time' do
    it 'fails the validation' do
      params.delete(:suspended_until)

      expect(subject.validate(params)).to be(false)
      expect(subject.errors[:suspended_until]).to be_present
    end
  end

  context 'with an invalid suspension time' do
    it 'fails the validation' do
      params[:suspended_until] = 1.month.ago

      expect(subject.validate(params)).to be(false)
      expect(subject.errors[:suspended_until]).to be_present
    end
  end
end
