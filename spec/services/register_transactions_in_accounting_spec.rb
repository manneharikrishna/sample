require 'rails_helper'

RSpec.describe RegisterTransactionsInAccounting do
  subject { described_class.new(:withdrawal) }

  let(:save_bundle_list_class) { TwentyFourSevenOffice::SaveBundleList }

  before do
    allow_any_instance_of(save_bundle_list_class).to receive(:call)
  end

  context 'when there are transactions from yesterday' do
    before { create_list(:withdrawal, 3, created_at: 1.day.ago) }

    it 'saves a bundle list' do
      expect_any_instance_of(save_bundle_list_class).to receive(:call)
      subject.call
    end
  end

  context 'when there are no transactions from yesterday' do
    it "doesn't save a bundle list" do
      expect_any_instance_of(save_bundle_list_class).not_to receive(:call)
      subject.call
    end
  end
end
