class RescheduleSubscription
  delegate :player, to: :@subscription

  def initialize(subscription, drawing)
    @subscription = subscription
    @drawing = drawing
  end

  def call
    delay_subscription
    send_payment_failure_email
  end

  private

  attr_reader :subscription
  attr_reader :drawing

  def delay_subscription
    SubscribeDrawingJob.set(wait: 24.hours).perform_later(subscription, drawing)
  end

  def send_payment_failure_email
    SubscriptionMailer.payment_failure(player).deliver_later
  end
end
