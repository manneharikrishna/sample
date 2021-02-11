require 'rails_helper'

RSpec.describe SendPasswordResetEmail, email: true do
  let(:redirect_url) { 'http://example.com/' }

  subject { described_class.new(:player, email, redirect_url) }

  context 'when the player is registered' do
    let(:email) { create(:player).email }

    it 'sends a password reset email' do
      perform_enqueued_jobs do
        expect { subject.call }.to change { deliveries.count }.by(1)
      end
    end
  end

  context 'when the player is not registered' do
    let(:email) { Faker::Internet.email }

    it "doesn't send a password reset email" do
      perform_enqueued_jobs do
        expect { subject.call }.not_to change { deliveries.count }
      end
    end
  end
end
