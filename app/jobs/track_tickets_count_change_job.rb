class TrackTicketsCountChangeJob < RetryableJob
  def perform(player, tickets_count)
    TrackTicketsCountChange.new(player, tickets_count).call
  end
end
