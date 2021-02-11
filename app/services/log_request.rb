class LogRequest
  def initialize(log_entry)
    @log_entry = log_entry
  end

  def call
    LogRepository.new.save(log_entry)
  end

  private

  attr_reader :log_entry
end
