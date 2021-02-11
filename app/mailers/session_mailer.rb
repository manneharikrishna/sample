class SessionMailer < ApplicationMailer
  def failed_limit_exceeded(user)
    @user = user

    I18n.with_locale(user.try(:language)) do
      mail to: user.email
    end
  end
end
