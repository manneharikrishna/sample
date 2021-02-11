class DeactivatePlayer
  def initialize(player)
    @player = player
  end

  def call
    cancel_subscription
    deactivate_player
  end

  private

  attr_reader :player

  def cancel_subscription
    CancelSubscription.new(player).call
  end

  def deactivate_player
    player.deactivate
  end
end
