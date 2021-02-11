require 'rails_helper'

RSpec.describe 'Password Reset API' do
  let(:path) { '/password_reset' }

  let(:player) { create(:player) }
  let(:token) { PasswordResetToken.new(player).generate }

  let(:redirect_url) { 'http://example.com/' }

  it 'sends a password reset email' do
    params = { email: player.email, redirect_url: redirect_url }

    post path, params: params

    expect(response).to have_http_status(201)
  end

  it 'resets the password' do
    params = { token: token, new_password: 'new_password' }

    patch path, params: params

    expect(response).to have_http_status(200)
  end
end
