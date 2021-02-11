require 'rails_helper'

RSpec.describe AppendTokenToUrl do
  let(:url) { 'http://example.com/' }
  let(:token) { Faker::Crypto.sha1 }

  subject { described_class.new(url, token) }

  it 'appends a token to a URL' do
    expect(subject.call).to eq("#{url}?token=#{token}")
  end
end
