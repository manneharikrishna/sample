class SuspendPlayer
  def initialize(player, reset_time)
    @player = player
    @reset_time = reset_time
  end

  def call
    cancel_subscription
    suspend_player
    schedule_suspension_reset
  end

  private

  attr_reader :player
  attr_reader :reset_time

  def cancel_subscription
    CancelSubscription.new(player).call
  end

  def suspend_player
    player.update!(suspended_until: reset_time)
  end

  def schedule_suspension_reset
    ResetSuspensionJob.set(wait_until: reset_time).perform_later(player)
  end
end
