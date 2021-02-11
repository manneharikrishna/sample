require 'rails_helper'

RSpec.describe SortingQuery do
  before { create_list(:entry, 2) }

  subject { described_class.new(Entry.all, :created_at, direction) }

  let(:entries) { Entry.order(created_at: direction) }

  context 'when the direction is descending' do
    let(:direction) { 'desc' }

    it 'returns records in descending order' do
      expect(subject.call).to eq(entries.to_a)
    end
  end

  context 'when the direction is ascending' do
    let(:direction) { 'asc' }

    it 'returns records in ascending order' do
      expect(subject.call).to eq(entries.to_a)
    end
  end

  context 'when the direction is invalid' do
    let(:direction) { 'invalid' }

    let(:entries) { Entry.order(:created_at) }

    it 'returns records in ascending order' do
      expect(subject.call).to eq(entries.to_a)
    end
  end

  context 'when the direction is not provided' do
    let(:direction) { 'asc' }

    subject { described_class.new(Entry.all, :created_at) }

    it 'returns records in ascending order' do
      expect(subject.call).to eq(entries.to_a)
    end
  end
end
