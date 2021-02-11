class TrackProfileChangeJob < RetryableJob
  def perform(player)
    TrackProfileChange.new(player).call
  end
end
