class TrackProfileChange
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
      '$first_name' => player.first_name,
      '$last_name' => player.last_name,
      '$email' => player.email,
      '$phone' => player.phone_number,
      'Birthdate' => player.birthdate
    }
  end
end
