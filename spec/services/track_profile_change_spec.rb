require 'rails_helper'

RSpec.describe TrackProfileChange, mixpanel: true do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  let(:payload) do
    {
      '$first_name' => player.first_name,
      '$last_name' => player.last_name,
      '$email' => player.email,
      '$phone' => player.phone_number,
      'Birthdate' => player.birthdate
    }
  end

  it 'registers the profile change in analytics' do
    expect(RegisterInAnalytics).to receive(:new).with(player, :set, payload).
      and_call_original

    expect_any_instance_of(RegisterInAnalytics).to receive(:call)

    subject.call
  end
end
