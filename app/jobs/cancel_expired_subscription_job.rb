class CancelExpiredSubscriptionJob < ApplicationJob
  def perform(subscription)
    return unless subscription.expired? && subscription.active?
    CancelExpiredSubscription.new(subscription.player, subscription).call
  end
end
