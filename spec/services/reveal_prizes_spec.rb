require 'rails_helper'

RSpec.describe RevealPrizes, email: true, mixpanel: true do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing) }

  it 'creates an award transaction' do
    expect { subject.call }.to change { Award.count }.by(1)
  end

  it 'sends a prize reveal email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end

  it 'reveals sold tickets' do
    subject.call

    expect(tickets[1].reload).to be_revealed
    expect(tickets[2].reload).to be_revealed
    expect(tickets[3].reload).to be_revealed

    expect(tickets[0].reload).not_to be_revealed
  end

  it 'changes tickets status to weekly autorevealed' do
    subject.call
    expect(tickets[1].reload.ticket_autoreveals.last.ticket_type).to eq('weekly')
    expect(tickets[2].reload.ticket_autoreveals.last.ticket_type).to eq('weekly')
    expect(tickets[3].reload.ticket_autoreveals.last.ticket_type).to eq('weekly')
  end

  context 'when the weekly prize is physical' do
    before { weekly_prize.update!(description: 'Car') }

    it "doesn't create an award" do
      expect { subject.call }.not_to change { Award.count }
    end
  end
end
