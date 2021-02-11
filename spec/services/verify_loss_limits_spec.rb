require 'rails_helper'

RSpec.describe VerifyLossLimits do
  let(:player) { create(:player) }

  subject { described_class.new(player, amount) }

  context "when the player's loss doesn't exceed any limit" do
    let(:amount) { 100 }

    it "doesn't raise an error" do
      expect { subject.call }.not_to raise_error
    end
  end

  context "when the player's weekly loss exceeds the limit" do
    let(:weekly_loss_limit) { Limits.weekly_loss_limit }
    let(:amount) { weekly_loss_limit + 100 }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context "when the player's daily loss exceeds the limit" do
    let(:daily_loss_limit) { Limits.daily_loss_limit }
    let(:amount) { daily_loss_limit + 100 }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
