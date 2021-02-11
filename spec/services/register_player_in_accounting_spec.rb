require 'rails_helper'

RSpec.describe RegisterPlayerInAccounting do
  let(:player) { create(:player) }

  subject { described_class.new(player) }

  let(:id) { Faker::Number.number(6).to_i }
  let(:save_company_class) { TwentyFourSevenOffice::SaveCompany }

  before do
    allow_any_instance_of(save_company_class).to receive(:call).and_return(id)
  end

  it 'sets the 24SevenOffice ID' do
    expect { subject.call }.to change { player.twenty_four_seven_office_id }.to(id)
  end
end
