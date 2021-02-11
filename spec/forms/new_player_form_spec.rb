require 'rails_helper'

RSpec.describe NewPlayerForm do
  subject { described_class.new(Player.new) }

  let(:params) { load_json_fixture(:new_player) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a first name' do
    before { params.delete('first_name') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a last name' do
    before { params.delete('last_name') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a birthdate' do
    before { params.delete('birthdate') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['birthdate']).to be_present
    end
  end

  context 'with an invalid birthdate' do
    before { params['birthdate'] = 17.years.ago }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['birthdate']).to be_present
    end
  end

  context 'without an SSN' do
    before { params.delete('ssn') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ssn']).to be_present
    end
  end

  context 'when the SSN has already been used' do
    before { create(:player, ssn: params['ssn']) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ssn']).to be_present
    end
  end

  context 'without a phone number' do
    before { params.delete('phone_number') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an invalid phone number' do
    before { params['phone_number'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['phone_number']).to be_present
    end
  end
end
