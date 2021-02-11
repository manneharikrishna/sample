require 'rails_helper'

RSpec.describe PaginationQuery do
  let!(:entry) { create_list(:entry, 3) }

  let(:page) { 1 }
  let(:per_page) { 2 }

  subject { described_class.new(Entry.all, page, per_page) }

  it 'returns paginated records' do
    expect(subject.call.count).to eq(per_page)
  end

  context 'when the page parameter is not provided' do
    let(:page) { nil }

    it 'returns the first page of records' do
      expect(subject.call.count).to eq(per_page)
    end
  end

  context 'when the per page parameter is blank' do
    let(:per_page) { '' }

    it 'returns all records' do
      expect(subject.call.count).to eq(Entry.count)
    end
  end
end
