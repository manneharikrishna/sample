require 'rails_helper'

RSpec.describe CancelLottery do
  subject { described_class.new(lottery) }

  context 'with a started lottery' do
    let(:lottery) { create(:lottery, :started) }
    let(:drawing) { create(:drawing, :ready, lottery: lottery) }

    it 'cancels the lottery' do
      expect { subject.call }.to change { lottery.status }.to(:cancelled)
    end

    it 'cancels lottery drawings' do
      expect { subject.call }.to change { drawing.status }.to(:cancelled)
    end
  end

  context 'with a pending lottery' do
    let(:lottery) { create(:lottery) }

    it 'raises an error' do
      expect { subject.call }.to raise_error(Statesman::TransitionFailedError)
    end
  end
end
