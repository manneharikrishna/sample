require 'rails_helper'

RSpec.describe Consultancy::DecodeGender do
  subject { described_class.new(player).call }

  context 'when the ssn has an even number' do
    let(:player) { create(:player, ssn: '12128923456') }

    it 'decodes players gender as female' do
      expect(subject).to eq('female')
    end
  end

  context 'when the ssn has an odd number' do
    let(:player) { create(:player, ssn: '12128923556') }

    it 'decodes players gender as male' do
      expect(subject).to eq('male')
    end
  end
end
