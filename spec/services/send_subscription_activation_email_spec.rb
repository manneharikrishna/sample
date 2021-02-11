require 'rails_helper'

RSpec.describe SendSubscriptionActivationEmail, email: true do
  let!(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  let(:player) { create(:player) }
  let(:subscription) { create(:subscription, :active, player: player) }

  subject { described_class.new(player, subscription) }

  it 'sends a subscription activation email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end
end
