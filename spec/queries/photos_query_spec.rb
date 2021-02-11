require 'rails_helper'

RSpec.describe PhotosQuery do
  let(:player) { create(:player) }

  let!(:photos) do
    [
      create(:photo, player: nil),
      create(:photo, player: player),
      create(:photo, player: player),
      create(:photo)
    ]
  end

  let!(:prize) { create(:prize) }
  let!(:entry) { create(:entry, photo: photos[1], player: player) }

  subject { described_class.new(player) }

  before do
    create_list(:ticket, 3, entry: entry, revealed_at: 1.day.ago, prize: prize)
  end

  it 'returns photos' do
    expect(subject.call).to match_array(photos[0..2])
  end

  it 'sorts photos by the number of winnings' do
    expect(subject.call).to eq([photos[1], photos[0], photos[2]])
  end
end
