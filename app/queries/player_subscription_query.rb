class PlayerSubscriptionQuery
  def initialize(player)
    @player = player
  end

  def call
    active_subscription || {}
  end

  private

  def active_subscription
    @player.subscriptions.find_by(status: 'active')
  end
end
