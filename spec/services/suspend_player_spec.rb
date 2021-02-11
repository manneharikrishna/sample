require 'rails_helper'

RSpec.describe SuspendPlayer do
  let(:player) { create(:player) }
  let(:reset_time) { 1.month.from_now }

  subject { described_class.new(player, reset_time) }

  it 'suspends a player' do
    subject.call
    expect(player).to be_suspended
  end

  it 'schedules the suspension reset' do
    expect { subject.call }.to enqueue_job(ResetSuspensionJob)
  end

  context 'with an active subscription' do
    let!(:subscription) { create(:subscription, :active, player: player) }

    it 'cancels the subscription' do
      expect_any_instance_of(CancelSubscription).to receive(:call)
      subject.call
    end
  end
end
