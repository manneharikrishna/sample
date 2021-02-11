require 'rails_helper'

RSpec.describe ResetPassword do
  let(:player) { create(:player) }
  let(:token) { PasswordResetToken.new(player).generate }
  let(:password) { 'new_password' }

  subject { described_class.new(:player, token, password) }

  it 'resets the password' do
    expect { subject.call }.to change { player.reload.password_digest }
  end

  context 'when provided with an invalid token' do
    let(:token) { JSONWebToken.encode(type: :invalid) }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context 'when provided with an invalid password' do
    let(:password) { 'invalid' }

    it 'fails the validation' do
      expect(subject.call.errors['password']).to be_present
    end

    it "doesn't reset the password" do
      expect { subject.call }.not_to change { player.reload.password_digest }
    end
  end
end
