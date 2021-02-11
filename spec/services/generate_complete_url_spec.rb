require 'rails_helper'

RSpec.describe GenerateCompleteUrl do
  let(:url) { 'http://example.com/' }
  let(:deposit) { create(:deposit) }

  subject { described_class.new(url, deposit) }

  it 'appends the deposit ID to a URL' do
    expected_url = "http://example.com/?deposit_id=#{deposit.id}"
    expect(subject.call).to eq(expected_url)
  end
end
