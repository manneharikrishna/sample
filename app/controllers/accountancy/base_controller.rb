class Accountancy::BaseController < ApplicationController
  before_action :authorize_request
  before_action :schedule_request_logging

  attr_reader :current_accountant
  alias_method :pundit_user, :current_accountant

  private

  def authorize_request
    authenticate_or_request_with_http_token do |token|
      @current_accountant = VerifyToken.new(token, :accountant, :session).call
    end
  end

  def schedule_request_logging
    ScheduleRequestLogging.new(request, current_accountant).call
  end
end
