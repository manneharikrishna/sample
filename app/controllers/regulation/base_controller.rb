class Regulation::BaseController < ApplicationController
  before_action :authorize_request
  before_action :schedule_request_logging

  attr_reader :current_regulator
  alias_method :pundit_user, :current_regulator

  private

  def authorize_request
    authenticate_or_request_with_http_token do |token|
      @current_regulator = VerifyToken.new(token, :regulator, :session).call
    end
  end

  def schedule_request_logging
    ScheduleRequestLogging.new(request, current_regulator).call
  end
end
