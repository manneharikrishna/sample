require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq.default_worker_options = { retry: false }

sidekiq_username = ENV.fetch('SIDEKIQ_USERNAME')
sidekiq_password = ENV.fetch('SIDEKIQ_PASSWORD')

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == sidekiq_username && password == sidekiq_password
end
