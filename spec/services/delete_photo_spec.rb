require 'rails_helper'

RSpec.describe DeletePhoto do
  let(:photo) { create(:photo, player: player) }
  let(:player) { create(:player) }

  subject { described_class.new(photo) }

  context 'when photo is not played' do
    it 'deletes photo' do
      subject.call
      expect(Photo.exists?(photo.id)).to eq(false)
    end
  end

  context 'when photo is played' do
    before { create(:entry, photo: photo) }

    it 'changes the photo visibility' do
      subject.call
      expect(photo.visible).to be_falsey
    end
  end

  context 'when photo is subscribed' do
    before { create(:subscription, photo: photo) }

    it 'changes the photo visibility' do
      subject.call
      expect(photo.visible).to be_falsey
    end
  end
end
