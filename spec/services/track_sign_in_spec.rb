require 'rails_helper'

RSpec.describe TrackSignIn, mixpanel: true do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  let(:current_time) { Time.current }
  let(:payload) { { 'Last Sign-In' => current_time } }

  it 'registers the sign-in in analytics' do
    allow(Time).to receive(:current).and_return(current_time)

    expect(RegisterInAnalytics).to receive(:new).with(player, :set, payload).
      and_call_original

    expect_any_instance_of(RegisterInAnalytics).to receive(:call)

    subject.call
  end
end
