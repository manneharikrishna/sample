class Rack::HealthCheck
  def call(_env)
    status = {
      redis: {
        connected: redis_connected?
      },
      postgres: {
        connected: postgres_connected?,
        migrations_updated: postgres_migrations_updated?
      }
    }

    [200, { 'Content-Type' => 'application/json' }, [status.to_json]]
  end

  protected

  def redis_connected?
    redis.ping == 'PONG'
  rescue StandardError
    false
  end

  def redis
    Redis.new
  end

  def postgres_connected?
    ApplicationRecord.connection
    ApplicationRecord.connected?
  rescue StandardError
    false
  end

  def postgres_migrations_updated?
    return false unless postgres_connected?

    !ActiveRecord::Migrator.needs_migration?
  end
end
