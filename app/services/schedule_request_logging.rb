class ScheduleRequestLogging
  def initialize(request, user)
    @request = request
    @user = user
  end

  def call
    LogRequestJob.perform_later(log_entry)
  end

  private

  attr_reader :request
  attr_reader :user

  def log_entry
    {
      method: request.method,
      path: request.path,
      params: request.filtered_parameters,
      user: { type: user_type, id: user&.id },
      ip_address: request.remote_ip,
      created_at: Time.current.iso8601
    }
  end

  def user_type
    user.class.name.underscore if user.present?
  end
end
