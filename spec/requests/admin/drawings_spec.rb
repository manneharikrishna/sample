require 'rails_helper'

RSpec.describe 'Drawings API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { '/admin/drawings' }

  let!(:drawing) { create(:predrawn_lottery_drawing) }

  it 'returns drawings details' do
    get "#{path}/#{drawing.id}", headers: headers

    expect(json_response['id']).to be_a(Numeric)
    expect(json_response['name']).to eq(drawing.name)
    expect(json_response['type']).to eq(drawing.lottery.type)
    expect(json_response['status']).to eq(drawing.status.to_s)
    expect(json_response['starts_at']).to be_present
    expect(json_response['ends_at']).to be_present
  end
end
