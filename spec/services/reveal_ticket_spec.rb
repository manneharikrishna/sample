require 'rails_helper'

RSpec.describe RevealTicket, email: true, mixpanel: true do
  let(:prize) { create(:prize) }
  let(:ticket) { create(:ticket, prize: prize) }

  subject { described_class.new(ticket) }

  it 'creates an award transaction' do
    expect_any_instance_of(CreateAward).to receive(:call)
    subject.call
  end

  it 'sends a prize reveal email' do
    perform_enqueued_jobs do
      expect { subject.call }.to change { deliveries.count }.by(1)
    end
  end

  it 'reveals the ticket' do
    expect { subject.call }.to change { ticket.reload.revealed? }.to(true)
  end

  context 'when the prize is physical' do
    let(:prize) { create(:prize, description: 'Car') }

    it "doesn't create an award" do
      expect { subject.call }.not_to change { Award.count }
    end
  end
end
