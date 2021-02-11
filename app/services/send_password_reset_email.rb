class SendPasswordResetEmail
  include UserHelper

  def initialize(user_type, email, redirect_url)
    @user_type = user_type
    @email = email
    @redirect_url = redirect_url
  end

  def call
    send_password_reset_email if user.present?
  end

  private

  attr_reader :redirect_url

  def send_password_reset_email
    PasswordMailer.password_reset(user, password_reset_url).deliver_later
  end

  def password_reset_url
    AppendTokenToUrl.new(redirect_url, password_reset_token).call
  end

  def password_reset_token
    PasswordResetToken.new(user).generate
  end
end
