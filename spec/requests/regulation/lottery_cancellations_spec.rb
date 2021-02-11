require 'rails_helper'

RSpec.describe 'Lottery Cancellations API' do
  let(:headers) { authorization_header(:regulator) }
  let(:path) { "/regulation/lotteries/#{lottery.id}/cancellation" }

  let(:lottery) { create(:lottery, :ready) }

  it 'creates a lottery cancellation' do
    post path, headers: headers

    expect(response).to have_http_status(201)
    expect(json_response['status']).to eq('cancelled')
  end
end
