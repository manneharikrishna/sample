class ResetSuspensionJob < RetryableJob
  def perform(player)
    return if player.suspended_until.nil?
    ResetSuspension.new(player).call
  end
end
