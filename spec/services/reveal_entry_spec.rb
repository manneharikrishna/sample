require 'rails_helper'

RSpec.describe RevealEntry, email: true, mixpanel: true do
  let(:entry) { create(:entry) }
  let(:ticket_type) { 'subscription' }

  let!(:ticket) { create(:ticket, entry: entry, prize: prize) }
  let!(:prize) { create(:prize) }

  subject { described_class.new(entry, ticket_type) }

  it 'creates an award transaction' do
    expect_any_instance_of(CreateAward).to receive(:call)
    subject.call
  end

  it 'sends a prize reveal email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end

  it 'reveals entry' do
    expect { subject.call }.to change { entry.reload.revealed? }.to(true)
  end

  it 'reveals tickets with instant prizes' do
    expect { subject.call }.to change { ticket.reload.revealed? }.to(true)
  end

  it 'creates ticket autoreveal of subscription type' do
    expect { subject.call }.to change { TicketAutoreveal.count }.by(1)
    expect(ticket.reload.ticket_autoreveals.last.ticket_type).to eq('subscription')
  end

  context 'when player is revealing tickets' do
    let(:ticket_type) { nil }

    it "doesn't create a ticket autoreveal" do
      expect { subject.call }.not_to change { TicketAutoreveal.count }
    end
  end

  context 'when the prize is physical' do
    let!(:prize) { create(:prize, description: 'Car') }

    it "doesn't create an award" do
      expect { subject.call }.not_to change { Award.count }
    end
  end
end
