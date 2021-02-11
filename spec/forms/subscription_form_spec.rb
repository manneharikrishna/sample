require 'rails_helper'

RSpec.describe SubscriptionForm do
  let(:player) { create(:player) }
  let(:photo) { create(:photo, player: player) }
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }
  let(:ticket_price) { drawing.lottery.ticket_price.to_i }

  subject { described_class.new(player) }

  let(:params) do
    {
      tickets_count: 2,
      photo_id: photo.id,
      drawing_id: drawing.id,
      redirect_url: 'http://example.com/nets-redirect',
      amount: 2 * ticket_price
    }
  end

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a tickets count' do
    before { params.delete(:tickets_count) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['tickets_count']).to be_present
    end
  end

  context 'with an invalid tickets count' do
    before { params[:tickets_count] = -1 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['tickets_count']).to be_present
    end
  end

  context 'without specified photo' do
    before { params.delete(:photo_id) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['photo_id']).to be_present
    end
  end

  context 'without specified drawing' do
    before { params.delete(:drawing_id) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['drawing_id']).to be_present
    end
  end

  context 'without a redirect URL' do
    before { params.delete(:redirect_url) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['redirect_url']).to be_present
    end
  end

  context 'with an invalid redirect URL' do
    before { params[:redirect_url] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['redirect_url']).to be_present
    end
  end

  context 'without an amount' do
    before { params.delete(:amount) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['amount']).to be_present
    end
  end
end
