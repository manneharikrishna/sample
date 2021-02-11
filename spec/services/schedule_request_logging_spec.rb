require 'rails_helper'

RSpec.describe ScheduleRequestLogging do
  let(:request) { double(load_json_fixture(:request)) }
  let(:player) { create(:player) }

  subject { described_class.new(request, player) }

  it 'schedules request logging' do
    expect { subject.call }.to enqueue_job(LogRequestJob)
  end
end
