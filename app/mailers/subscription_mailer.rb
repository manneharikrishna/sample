class SubscriptionMailer < ApplicationMailer
  def activation(player, amount, tickets_count)
    @player = player
    @amount = amount
    @tickets_count = tickets_count
    @dashboard_redirect_url = ENV['DASHBOARD_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email, subject: subject
    end
  end

  def cancellation(player)
    @player = player
    @dashboard_redirect_url = ENV['DASHBOARD_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email, subject: subject
    end
  end

  def payment_failure(player)
    @player = player
    @profile_redirect_url = ENV['PROFILE_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email, subject: subject
    end
  end

  def expiration(player)
    @player = player
    @profile_redirect_url = ENV['PROFILE_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email, subject: subject
    end
  end

  def upcoming_expiration(player)
    @player = player
    @profile_redirect_url = ENV['PROFILE_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email, subject: subject
    end
  end

  private

  def subject
    default_i18n_subject(application: LOCAL_APP_NAME)
  end
end
