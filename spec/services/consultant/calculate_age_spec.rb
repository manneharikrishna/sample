require 'rails_helper'

RSpec.describe Consultancy::CalculateAge do
  let(:player) { create(:player, birthdate: 19.years.ago) }

  subject { described_class.new(player).call }

  it 'calculates age of a player' do
    expect(subject).to eq(19)
  end
end
