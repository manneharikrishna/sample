class WithdrawalMailer < ApplicationMailer
  include CurrencyHelper

  def bank_transfer(player, withdrawal)
    @player = player
    @amount = amount_with_currency(-withdrawal.amount)
    @limit = amount_with_currency(Limits.balance_limit)
    @profile_redirect_url = ENV['PROFILE_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email
    end
  end

  def missing_bank_account_number(player)
    @player = player
    @limit = amount_with_currency(Limits.balance_limit)
    @profile_redirect_url = ENV['PROFILE_REDIRECT_URL']

    I18n.with_locale(player.language) do
      mail to: @player.email
    end
  end
end
