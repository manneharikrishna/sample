require 'rails_helper'

RSpec.describe TrackTicketsCountChange, mixpanel: true do
  let(:player) { create(:player) }
  let(:tickets_count) { 10 }

  subject { described_class.new(player, tickets_count) }

  let(:payload) { { 'Tickets Bought' => tickets_count } }

  it 'registers the tickets count change in analytics' do
    expect(RegisterInAnalytics).to receive(:new).with(player, :increment, payload).
      and_call_original

    expect_any_instance_of(RegisterInAnalytics).to receive(:call)

    subject.call
  end
end
