require 'rails_helper'

RSpec.describe ActivatePlayer, email: true do
  let(:player) { create(:player, activated_at: nil) }

  subject { described_class.new(player) }

  it 'activates the player' do
    expect { subject.call }.to change { player.reload.activated? }
  end

  it 'sends a welcome email' do
    expect { subject.call }.to enqueue_job.on_queue('mailers')
  end

  it 'schedules registration in accounting' do
    expect { subject.call }.to enqueue_job(RegisterPlayerInAccountingJob)
  end
end
