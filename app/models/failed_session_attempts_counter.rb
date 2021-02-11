class FailedSessionAttemptsCounter
  include ActiveModel::Serialization

  def today
    failed_session_counter(Time.current.all_day)
  end

  def yesterday
    failed_session_counter(1.day.ago.all_day)
  end

  def week
    failed_session_counter(7.days.ago.beginning_of_day..Time.current.end_of_day)
  end

  def last_week
    failed_session_counter(14.days.ago.beginning_of_day..7.days.ago.end_of_day)
  end

  def percentage_today
    ((today.to_f / all_today.to_f) * 100).ceil
  end

  def all_today
    today + today_success_session_counter
  end

  def status
    today >= ENV['FAILED_SESSION_LIMIT'].to_i ? 'alarm' : 'normal'
  end

  private

  def failed_session_counter(date_range)
    FailedSessionAttempt.where(created_at: date_range).sum(&:counter)
  end

  def today_success_session_counter
    SuccessSessionAttempt.where(created_at: Time.current.all_day)[0]&.counter || 1
  end
end
