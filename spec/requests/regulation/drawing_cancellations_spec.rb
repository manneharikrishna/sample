require 'rails_helper'

RSpec.describe 'Drawing Cancellation API' do
  let(:headers) { authorization_header(:regulator) }
  let(:path) { "/regulation/drawings/#{drawing.id}/cancellation" }

  let(:drawing) { create(:drawing, :ready) }

  it 'creates a drawing cancellation' do
    post path, headers: headers

    expect(response).to have_http_status(201)
    expect(json_response['status']).to eq('cancelled')
  end
end
