require 'rails_helper'

RSpec.describe EndDrawing, email: true do
  let!(:drawing) { create(:pool_lottery_drawing, :started) }

  subject { described_class.new(drawing) }

  before { allow_any_instance_of(CreateWinning).to receive(:call) }

  it 'updates the drawing status' do
    expect { subject.call }.to change { drawing.status }.to(:ended)
  end

  context 'with a pool drawing' do
    it 'creates a winning' do
      expect_any_instance_of(CreateWinning).to receive(:call)
      subject.call
    end
  end

  context 'with a social drawing' do
    let(:drawing) { create(:social_lottery_drawing, :started) }

    it 'creates a winning' do
      expect_any_instance_of(CreateWinning).to receive(:call)
      subject.call
    end
  end

  context 'with a pre-drawn drawing' do
    let!(:drawing) { create(:predrawn_lottery_drawing, :started) }
    let!(:prize) { create(:prize, :weekly) }
    let!(:tickets) { create_list(:ticket, 2, drawing: drawing, prize: prize) }

    it "doesn't create a winning" do
      expect_any_instance_of(CreateWinning).not_to receive(:call)
      subject.call
    end

    it 'sends weekly reminder emails' do
      perform_enqueued_jobs do
        expect { subject.call }.to change { deliveries.count }
      end
    end

    it 'reveals entries' do
      expect_any_instance_of(RevealEntries).to receive(:call)
      subject.call
    end
  end

  it 'repeats the drawing' do
    expect_any_instance_of(RepeatDrawing).to receive(:call)
    subject.call
  end

  it 'creates next drawing' do
    expect { subject.call }.to change { Drawing.count }.from(1).to(2)
  end

  context 'when the next drawing would exceed lottery end time' do
    before do
      drawing.lottery.update!(
        starts_at: Time.current,
        ends_at: 1.minute.from_now,
        repeat_every: 120
      )
    end

    it "doesn't repeat drawing" do
      expect_any_instance_of(RepeatDrawing).not_to receive(:call)
      subject.call
    end
  end
end
