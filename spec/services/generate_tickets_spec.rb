require 'rails_helper'

RSpec.describe GenerateTickets do
  let(:drawing) { create(:drawing, tickets_count: 1000) }

  subject { described_class.new(drawing) }

  it 'generates tickets' do
    expect { subject.call }.to change { drawing.tickets.count }.to(1000)
  end
end
