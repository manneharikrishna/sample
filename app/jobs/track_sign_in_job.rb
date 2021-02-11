class TrackSignInJob < RetryableJob
  def perform(player)
    TrackSignIn.new(player).call
  end
end
