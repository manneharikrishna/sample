require 'rails_helper'

RSpec.describe 'Loss Limits API' do
  let(:headers) { authorization_header(:player) }

  it "sets player's loss limits" do
    params = load_json_fixture(:loss_limits)

    put '/loss_limits', params: params, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response['weekly_loss_limit']).to eq(params['weekly_loss_limit'])
    expect(json_response['daily_loss_limit']).to eq(params['daily_loss_limit'])
  end
end
