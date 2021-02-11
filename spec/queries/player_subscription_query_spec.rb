require 'rails_helper'

RSpec.describe PlayerSubscriptionQuery do
  let!(:player) { create(:player) }

  let!(:active_subscription) { create(:subscription, :active, player: player) }
  let!(:inactive_subscription) { create(:subscription, :inactive, player: player) }

  subject { described_class.new(player) }

  it 'returns active subscription' do
    result = subject.call

    expect(result).to match(active_subscription)
    expect(result).not_to match(inactive_subscription)
  end
end
