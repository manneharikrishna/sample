require 'rails_helper'

RSpec.describe ActivationForm do
  subject { described_class.new(Player.create!) }

  let(:params) { load_json_fixture(:activation) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
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

  context 'without an email' do
    before { params.delete('email') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['email']).to be_present
    end
  end

  context 'with an invalid email' do
    before { params['email'] = 'invalid@email' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['email']).to be_present
    end
  end

  context 'when the email has already been used' do
    before { create(:player, email: params['email']) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['email']).to be_present
    end
  end

  context 'without a password' do
    before { params.delete('password') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['password']).to be_present
    end
  end

  context 'when the password is too short' do
    before { params['password'] = '1234567' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['password']).to be_present
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

  context 'without the Politically Exposed Person flag' do
    before { params.delete('is_pep') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end
end
