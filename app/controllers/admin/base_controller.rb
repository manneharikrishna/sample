class Admin::BaseController < ApplicationController
  before_action :authorize_request
  before_action :schedule_request_logging

  attr_reader :current_operator
  alias_method :pundit_user, :current_operator

  private

  def authorize_request
    authenticate_or_request_with_http_token do |token|
      @current_operator = VerifyToken.new(token, :operator, :session).call
    end
  end

  def schedule_request_logging
    ScheduleRequestLogging.new(request, current_operator).call
  end
end
