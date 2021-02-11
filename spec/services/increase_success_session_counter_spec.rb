require 'rails_helper'

RSpec.describe IncreaseSuccessSessionCounter do
  let!(:success_session_attempt) { create(:success_session_attempt) }

  subject { described_class.new }

  it 'increases success session counter' do
    expect { subject.call }.to change { success_session_attempt.reload.counter }.to(1)
  end
end
