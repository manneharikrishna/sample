class PasswordMailer < ApplicationMailer
  def password_reset(user, password_reset_url)
    @user = user
    @password_reset_url = password_reset_url

    I18n.with_locale(user.try(:language)) do
      mail to: user.email
    end
  end
end
