class SubscribeDrawing
  delegate :player, to: :@subscription

  def initialize(subscription, drawing)
    @subscription = subscription
    @drawing = drawing
  end

  def call
    return unless drawing.status == :started && subscription.active?

    return reschedule_subscription unless verified_subscription_policy?

    suppress(Nets::Error) do
      create_deposit
      assign_subscription_deposit
      verify_subscription
    end

    reschedule_subscription unless deposit.completed?
  end

  private

  attr_reader :subscription
  attr_reader :drawing
  attr_reader :deposit

  def verified_subscription_policy?
    VerifySubscriptionPolicy.new(player, amount).call
  end

  def delay_subscription
    SubscribeDrawingJob.set(wait: 24.hours).perform_later(subscription, drawing)
  end

  def create_deposit
    @deposit ||= Deposits::Create.new(player, payload).call
  end

  def payload
    Deposits::ConfigureRecurringPaymentPayload.new(player, payment_params)
  end

  def payment_params
    {
      amount: amount,
      nets_token: subscription.nets_token
    }
  end

  def amount
    subscription.tickets_count * drawing.lottery.ticket_price.to_i
  end

  def assign_subscription_deposit
    deposit.update!(subscription_id: subscription.id)
  end

  def verify_subscription
    VerifySubscription.new(subscription, deposit, drawing).call
  end

  def reschedule_subscription
    RescheduleSubscription.new(subscription, drawing).call
  end
end
