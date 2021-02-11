require 'rails_helper'

RSpec.describe ChangePassword do
  let(:player) { create(:player, password: 'password') }

  let(:password) { 'password' }
  let(:new_password) { 'new_password' }

  subject { described_class.new(player, password, new_password) }

  context 'when provided with a valid password' do
    it 'changes the password' do
      expect { subject.call }.to change { player.password_digest }
    end
  end

  context 'when provided a wrong password' do
    let(:password) { 'wrong' }

    it "doesn't change the password" do
      expect { subject.call }.not_to change { player.password_digest }
    end
  end
end
