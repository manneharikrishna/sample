require 'rails_helper'

RSpec.describe MergeUrlParameters do
  let(:base_url) { 'http://example.com/' }
  let(:params) { { param: 'test' } }

  subject { described_class.new(url, params) }

  context 'when the URL has no parameters' do
    let(:url) { base_url }
    let(:expected_url) { "#{base_url}?param=test" }

    it 'adds a parameter' do
      expect(subject.call).to eq(expected_url)
    end
  end

  context 'when the URL has other parameters' do
    let(:url) { "#{base_url}?other=value" }
    let(:expected_url) { "#{base_url}?other=value&param=test" }

    it 'appends a parameter' do
      expect(subject.call).to eq(expected_url)
    end
  end

  context 'when the URL has the same parameter' do
    let(:url) { "#{base_url}?param=value" }
    let(:expected_url) { "#{base_url}?param=test" }

    it 'updates the parameter' do
      expect(subject.call).to eq(expected_url)
    end
  end
end
