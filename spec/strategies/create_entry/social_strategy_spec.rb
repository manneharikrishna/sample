require 'rails_helper'

RSpec.describe CreateEntry::SocialStrategy do
  let(:entry) { create(:entry, tickets_count: 5) }

  subject { described_class.new(entry, {}) }

  it 'overrides the tickets count' do
    subject.call
    expect(entry.tickets_count).to eq(1)
  end

  it 'creates a single ticket associated with the entry' do
    subject.call
    expect(entry.tickets.count).to eq(1)
  end
end
