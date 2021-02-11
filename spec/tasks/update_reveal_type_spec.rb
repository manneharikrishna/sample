require 'rails_helper'

RSpec.describe 'fotolotto:update_reveal_type' do
  let!(:weekly_prize) { create(:prize, reveal_type: 'lottery_end') }
  let!(:instant_prize) { create(:prize, reveal_type: 'instant') }

  before do
    FotoLotto::Application.load_tasks
    Rake::Task['fotolotto:update_reveal_type'].invoke
  end

  it 'updates the reveal type only for weekly prizes' do
    expect(weekly_prize.reload.reveal_type).to eq('drawing_end')
    expect(instant_prize.reload.reveal_type).to eq('instant')
  end
end
