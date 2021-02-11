require 'rails_helper'

RSpec.describe CreateEntry do
  let(:drawing) { create(:social_lottery_drawing) }

  let(:player) { create(:player) }
  let(:photo) { create(:photo, player: player) }

  let(:params) { { photo_id: photo.id } }

  subject { described_class.new(drawing, player, params) }

  it 'creates an entry' do
    result = subject.call

    expect(result).to be_an(Entry)

    expect(result.player).to eq(player)
    expect(result.photo).to eq(photo)

    expect(result.status).to eq('pending')
    expect(result.tickets_count).to eq(1)
  end

  it 'schedules tickets count change tracking' do
    expect { subject.call }.to enqueue_job(TrackTicketsCountChangeJob)
  end
end
