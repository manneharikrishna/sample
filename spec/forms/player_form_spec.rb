require 'rails_helper'

RSpec.describe PlayerForm, kar: true do
  let(:player) { Player.create!(ssn: '11037934560') }

  subject { described_class.new(player) }

  let(:params) { load_json_fixture(:player) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end

    it 'schedules registration in accounting' do
      expect { subject.save }.to enqueue_job(RegisterPlayerInAccountingJob)
    end

    it 'schedules profile change tracking' do
      expect { subject.save }.to enqueue_job(TrackProfileChangeJob)
    end
  end

  context 'without a first name' do
    before { params.delete('first_name') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['first_name']).to be_present
    end
  end

  context 'without a last name' do
    before { params.delete('last_name') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['last_name']).to be_present
    end
  end

  context 'with an invalid phone number' do
    before { params['phone_number'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['phone_number']).to be_present
    end
  end

  context 'without a phone number' do
    before { params.delete('phone_number') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an invalid bank account number' do
    before { params['bank_account_number'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['bank_account_number']).to be_present
    end
  end

  context 'with an invalid bank account number' do
    before { params['bank_account_number'] = '123' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['bank_account_number']).to be_present
    end
  end

  context 'when the player is from Norway' do
    context 'when the bank account does not belong to the player' do
      before do
        ENV['COUNTRY_CODE'] = 'NO'
        params['bank_account_number'] = FakeKAR::NOT_OWNED
      end

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['bank_account_number']).to be_present
      end
    end
  end

  context 'when the player is from Sweden' do
    context 'when the bank account does not belong to the player' do
      before do
        ENV['COUNTRY_CODE'] = 'SE'
        params['bank_account_number'] = FakeKAR::NOT_OWNED
      end

      it 'passes the validation' do
        expect(subject.validate(params)).to eq(true)
      end
    end
  end

  context 'without a bank account number' do
    before { params.delete('bank_account_number') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an empty bank account number' do
    before { params['bank_account_number'] = '' }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an invalid language' do
    before { params['language'] = :pl }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['language']).to be_present
    end
  end

  context 'without a language' do
    before { params.delete('language') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'with an empty language' do
    before { params['language'] = '' }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end
end
