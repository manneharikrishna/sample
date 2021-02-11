class IncreaseSuccessSessionCounter
  def call
    success_session_attempt.update!(counter: success_session_counter + 1)
  end

  private

  def success_session_attempt
    @success_session_attempt ||= begin
      SuccessSessionAttempt.where(created_at: Time.current.all_day).first_or_create
    end
  end

  def success_session_counter
    success_session_attempt.counter
  end
end
