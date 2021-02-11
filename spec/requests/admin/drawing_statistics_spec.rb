require 'rails_helper'

RSpec.describe 'Drawing Statistics API' do
  let(:headers) { authorization_header(:operator) }
  let(:path) { "/admin/drawings/#{drawing.id}/statistics" }

  include_context 'a drawing with sold tickets' do
    let!(:drawing) { create(:drawing, :started, ticket_price: 25) }
  end

  it_behaves_like 'Drawing Statistics API'
end
