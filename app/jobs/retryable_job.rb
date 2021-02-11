class RetryableJob < ApplicationJob
  retry_on StandardError, wait: :exponentially_longer
end
