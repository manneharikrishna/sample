class IncreaseFailedSessionCounter
  def call
    failed_session_attempt.update!(counter: failed_session_counter + 1)
    send_limit_exceeded_email if failed_session_exceeded?
  end

  private

  def failed_session_attempt
    @failed_session_attempt ||= begin
      FailedSessionAttempt.where(created_at: Time.current.all_day).first_or_create
    end
  end

  def failed_session_counter
    failed_session_attempt.counter
  end

  def failed_session_exceeded?
    failed_session_counter >= failed_session_limit
  end

  def failed_session_limit
    ENV['FAILED_SESSION_LIMIT'].to_i
  end

  def send_limit_exceeded_email
    Operator.all.each do |operator|
      SessionMailer.failed_limit_exceeded(operator).deliver_later
    end
  end
end
