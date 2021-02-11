class TrackSignIn
  def initialize(player)
    @player = player
  end

  def call
    RegisterInAnalytics.new(player, :set, payload).call
  end

  private

  attr_reader :player

  def payload
    {
      'Last Sign-In' => Time.current
    }
  end
end
