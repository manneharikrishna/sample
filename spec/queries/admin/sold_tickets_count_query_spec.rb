require 'rails_helper'

RSpec.describe Admin::SoldTicketsCountQuery do
  include_context 'a drawing with sold tickets'

  subject { described_class.new(drawing) }

  it 'returns the sold tickets count' do
    expect(subject.call).to eq(3)
  end
end
