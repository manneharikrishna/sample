class LogRequestJob < RetryableJob
  def perform(log_entry)
    LogRequest.new(log_entry).call
  end
end
