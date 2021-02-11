require 'rails_helper'

RSpec.describe RegisterInAnalytics, mixpanel: true do
  let(:player) { create(:player) }
  let(:method) { :set }
  let(:payload) { { first_name: Faker::Name.first_name } }

  subject { described_class.new(player, method, payload) }

  context 'when provided with an invalid method' do
    let(:method) { :invalid }

    it 'raises an error' do
      expect { subject.call }.to raise_error('Method not allowed')
    end
  end

  context 'when the registration in Mixpanel fails' do
    it 'raises an error' do
      allow_any_instance_of(RegisterInAnalytics).to receive(:register_in_mixpanel).
        and_return(false)

      expect { subject.call }.to raise_error('Registration in Mixpanel failed')
    end
  end
end
