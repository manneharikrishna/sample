require 'rails_helper'

RSpec.describe CreateSubscription, nets: true do
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  let(:player) { create(:player) }
  let(:photo) { create(:photo, player: player) }

  let(:params) do
    {
      tickets_count: 2,
      photo_id: photo.id,
      redirect_url: 'http://example.com/nets-redirect'
    }
  end

  subject { described_class.new(player, params) }

  it 'creates a subscription' do
    result = subject.call

    expect(result).to be_an(Subscription)

    expect(result.player).to eq(player)
    expect(result.tickets_count).to eq(params[:tickets_count])
    expect(result.photo).to eq(photo)
    expect(result.status).to eq('inactive')
  end

  it 'creates a deposit' do
    expect { subject.call }.to change { Deposit.count }.by(1)
  end

  it 'sets redirect url' do
    result = subject.call

    expect(result.redirect_url).to be_present
  end

  it 'assigns a subscription to deposit' do
    subject.call
    expect(player.deposits.last.subscription_id).to be_present
  end
end
