require 'rails_helper'

RSpec.describe CalculatePrizePayout do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(instant_prize) }

  context 'with winning tickets' do
    it 'returns the prize payout' do
      expect(subject.call).to eq(10)
    end
  end

  context 'without winning tickets' do
    let!(:tickets) { create_list(:ticket, 2, drawing: drawing) }

    it 'returns zero' do
      expect(subject.call).to eq(0)
    end
  end
end
