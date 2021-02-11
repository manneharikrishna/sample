require 'rails_helper'

RSpec.describe IncreaseFailedSessionCounter, email: true do
  let!(:failed_session_attempt) { create(:failed_session_attempt) }

  subject { described_class.new }

  it 'increases failed session counter' do
    expect { subject.call }.to change { failed_session_attempt.reload.counter }.by(1)
  end

  context 'with exceeded failed session limit' do
    let!(:operator) { create(:operator) }
    let!(:failed_session_attempt) do
      create(:failed_session_attempt, counter: ENV['FAILED_SESSION_LIMIT'])
    end

    it 'sends a failed session limit exceeded email' do
      perform_enqueued_jobs do
        expect { subject.call }.to change { deliveries.count }.by(1)
      end
    end
  end
end
