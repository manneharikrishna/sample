require 'rails_helper'

RSpec.describe LogRequest do
  subject { described_class.new({}) }

  it 'logs a request' do
    log_repository = double('LogRepository')

    allow(LogRepository).to receive(:new) { log_repository }
    expect(log_repository).to receive(:save)

    subject.call
  end
end
