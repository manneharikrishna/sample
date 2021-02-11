require 'rails_helper'

RSpec.describe ResetSuspension do
  let(:player) { create(:player, suspended_until: 1.month.from_now) }

  subject { described_class.new(player) }

  it 'resets a player suspension' do
    expect { subject.call }.to change { player.suspended_until }.to(nil)
  end
end
