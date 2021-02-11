class TrackWalletBalanceJob < RetryableJob
  def perform(player, balance)
    TrackWalletBalance.new(player, balance).call
  end
end
