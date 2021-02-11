require 'rails_helper'

RSpec.describe 'Withdrawals API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { '/admin/withdrawals' }

  let!(:withdrawal) { create(:withdrawal) }

  it 'returns a list of withdrawals' do
    get path, headers: headers

    expect(response).to have_http_status(200)

    expect(json_response).to be_an(Array)
    expect(json_response).not_to be_empty

    expect(json_response[0]).to include('id')
    expect(json_response[0]).to include('amount')
    expect(json_response[0]).to include('created_at')
    expect(json_response[0]).to include('bank_account_number')
    expect(json_response[0]).to include('player_name')
  end
end
