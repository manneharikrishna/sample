require 'rails_helper'

RSpec.describe RevealEntries do
  let(:entries) { create_list(:entry, 3, drawing: drawing) }
  let(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }

  let!(:ticket) { create(:ticket, entry: entries.first, prize: prize) }
  let!(:prize) { create(:prize) }

  subject { described_class.new(drawing) }

  it 'reveals entries' do
    expect { subject.call }.to change { entries.first.reload.revealed? }.to(true)
  end

  it 'reveals tickets with instant prizes' do
    expect { subject.call }.to change { ticket.reload.revealed? }.to(true)
  end

  it 'creates ticket autoreveal' do
    expect { subject.call }.to change { TicketAutoreveal.count }.by(1)
  end
end
