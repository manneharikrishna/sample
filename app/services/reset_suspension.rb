class ResetSuspension
  def initialize(player)
    @player = player
  end

  def call
    player.update!(suspended_until: nil)
  end

  private

  attr_reader :player
end
