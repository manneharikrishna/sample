class BaseController < ApplicationController
  before_action :authorize_request
  before_action :schedule_request_logging

  before_action :ensure_player_activated

  around_action :set_locale

  attr_reader :current_player
  alias_method :pundit_user, :current_player

  private

  def authorize_request
    authenticate_or_request_with_http_token do |token|
      @current_player = VerifyToken.new(token, :player, :session).call
    end
  end

  def schedule_request_logging
    ScheduleRequestLogging.new(request, current_player).call
  end

  def ensure_player_activated
    head :forbidden unless current_player.activated?
  end

  def set_locale(&block)
    locale = current_player&.language || I18n.default_locale
    I18n.with_locale(locale, &block)
  end

  def ensure_player_not_suspended
    head :forbidden if current_player.suspended?
  end

  def verify_loss_limits
    VerifyLossLimits.new(current_player, params[:amount]).call
  end

  def verify_balance_limit
    VerifyBalanceLimit.new(params[:amount], current_player).call
  end

  def verify_transfer_limit
    VerifyTransferLimit.new(params[:amount]).call
  end

  def authorize_entry
    authorize(drawing, :entry)
  end
end
