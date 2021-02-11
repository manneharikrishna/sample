class CancelExpiredSubscription
  def initialize(player, subscription)
    @player = player
    @subscription = subscription
  end

  def call
    if subscription.active?
      cancel_subscription
      send_subscription_cancellation_email
    end
  end

  private

  attr_reader :player
  attr_reader :subscription

  def cancel_subscription
    subscription.update!(status: 'cancelled', data: nil)
  end

  def send_subscription_cancellation_email
    SubscriptionMailer.expiration(player).deliver_later
  end
end
