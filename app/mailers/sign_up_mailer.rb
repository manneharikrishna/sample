class SignUpMailer < ApplicationMailer
  def welcome(player)
    @player = player
    @dashboard_redirect_url = ENV['DASHBOARD_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: player.email, subject: subject
    end
  end

  private

  def subject
    default_i18n_subject(application: LOCAL_APP_NAME)
  end
end
