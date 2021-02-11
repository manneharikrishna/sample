require 'rails_helper'

RSpec.describe Admin::EntriesQuery do
  let(:drawing) { create(:social_lottery_drawing) }
  let(:entries) { drawing.entries }

  it 'returns drawing entries' do
    result = described_class.new(drawing).call
    expect(result).to match_array(entries)
  end

  it 'filters drawing entries' do
    params = { status: 'approved' }
    result = described_class.new(drawing, params).call

    expect(result).to match_array(entries.approved)
  end

  it 'sorts drawing entries' do
    params = { order: 'asc' }
    result = described_class.new(drawing, params).call

    expect(result).to eq(entries.order(:created_at))
  end

  it 'paginates drawing entries' do
    params = { per_page: 1, page: 2 }
    result = described_class.new(drawing, params).call

    expect(result.count).to eq(1)
  end
end
