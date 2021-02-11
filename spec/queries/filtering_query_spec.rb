require 'rails_helper'

RSpec.describe FilteringQuery do
  let!(:entries) { create_list(:entry, 2) }
  let!(:approved_entries) { create_list(:entry, 2, status: 'approved') }

  subject { described_class.new(Entry.all, :status, value) }

  context 'when the value is provided' do
    let(:value) { 'approved' }

    it 'returns filtered records' do
      expect(subject.call).to match_array(approved_entries)
    end
  end

  context 'when the value is not provided' do
    let(:value) { nil }

    it 'returns unfiltered records' do
      expect(subject.call).to match_array(Entry.all)
    end
  end
end
