class PrizeMailer < ApplicationMailer
  add_template_helper CurrencyHelper

  def prize_reveal(entry, prizes)
    @player = entry.player
    @prizes = prizes
    @drawing = entry.drawing
    @balance_limit = ENV['BALANCE_LIMIT']
    @dashboard_redirect_url = ENV['DASHBOARD_REDIRECT_URL']

    I18n.with_locale(@player.language) do
      mail to: @player.email, subject: subject
    end
  end

  def weekly_reminder(player, golden_tickets, drawing, weekly_lottery_url)
    @player = player
    @golden_tickets = golden_tickets
    @drawing = drawing
    @weekly_lottery_url = weekly_lottery_url

    I18n.with_locale(@player.language) do
      mail to: @player.email, subject: subject
    end
  end

  private

  def subject
    default_i18n_subject(application: LOCAL_APP_NAME)
  end
end
