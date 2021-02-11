class SendSubscriptionExpirationEmailJob < ApplicationJob
  def perform(subscription)
    return unless subscription.active?
    SubscriptionMailer.upcoming_expiration(subscription.player).deliver_later
  end
end
