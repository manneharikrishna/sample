require 'rails_helper'

RSpec.describe EndLottery, email: true do
  let(:lottery) { create(:lottery, :started) }

  subject { described_class.new(lottery) }

  it 'updates the lottery status' do
    expect { subject.call }.to change { lottery.status }.to(:ended)
  end
end
