class CancelSubscription
  def initialize(player)
    @player = player
  end

  def call
    if active_subscription.present?
      cancel_subscription
      send_subscription_cancellation_email
    end
  end

  private

  attr_reader :player

  def cancel_subscription
    active_subscription.update!(status: 'cancelled', data: nil)
  end

  def active_subscription
    @active_subscription ||= PlayerSubscriptionQuery.new(player).call
  end

  def send_subscription_cancellation_email
    SubscriptionMailer.cancellation(player).deliver_later
  end
end
