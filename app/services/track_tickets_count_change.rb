class TrackTicketsCountChange
  def initialize(player, tickets_count)
    @player = player
    @tickets_count = tickets_count
  end

  def call
    RegisterInAnalytics.new(player, :increment, payload).call
  end

  private

  attr_reader :player
  attr_reader :tickets_count

  def payload
    {
      'Tickets Bought' => tickets_count
    }
  end
end
