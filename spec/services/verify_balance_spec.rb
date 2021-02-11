require 'rails_helper'

RSpec.describe VerifyBalance do
  let(:player) { create(:player) }
  let(:amount) { 5 }

  subject { described_class.new(player, amount) }

  context 'with an amount not exceeding the balance' do
    before do
      create(:deposit, amount: 100, player: player)
    end

    it "doesn't raise an error" do
      expect { subject.call }.not_to raise_error
    end
  end

  context 'with an amount exceeding the balance' do
    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
