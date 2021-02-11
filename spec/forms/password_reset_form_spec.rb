require 'rails_helper'

RSpec.describe PasswordResetForm do
  subject { described_class.new(Operator.new) }

  let(:params) { load_json_fixture(:password_reset) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
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
    before { params['email'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['email']).to be_present
    end
  end

  context 'without a redirect URL' do
    before { params.delete('redirect_url') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['redirect_url']).to be_present
    end
  end

  context 'with an invalid redirect URL' do
    before { params['redirect_url'] = 'invalid' }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['redirect_url']).to be_present
    end
  end

  context 'with a redirect URL' do
    context 'with a disallowed host' do
      before { params['redirect_url'] = 'http://disallowed.host/' }

      it 'fails the validation' do
        expect(subject.validate(params)).to eq(false)
        expect(subject.errors['redirect_url']).to be_present
      end
    end
  end
end
