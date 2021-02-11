class Consultancy::BaseController < ApplicationController
  before_action :authorize_request
  before_action :schedule_request_logging

  attr_reader :current_consultant
  alias_method :pundit_user, :current_consultant

  private

  def authorize_request
    authenticate_or_request_with_http_token do |token|
      @current_consultant = VerifyToken.new(token, :consultant, :session).call
    end
  end

  def schedule_request_logging
    ScheduleRequestLogging.new(request, current_consultant).call
  end
end
