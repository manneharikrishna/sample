class ActivateSubscription
  delegate :player, to: :@subscription
  delegate :nets_payment_id, to: :@deposit

  def initialize(subscription, deposit)
    @subscription = subscription
    @deposit = deposit
  end

  def call
    if deposit.completed? && active_subscription.blank?
      activate_subscription
      send_subscription_activation_email
      schedule_cancelling_subscription
      schedule_expiration_reminder
    end
  end

  private

  attr_reader :subscription
  attr_reader :deposit

  def active_subscription
    PlayerSubscriptionQuery.new(player).call
  end

  def activate_subscription
    subscription.update!(
      status: 'active',
      nets_token: nets_payment.token,
      payment_method: nets_payment.payment_method,
      card_expiration_date: nets_payment.card_expiration_date,
      card_last_digits: nets_payment.card_last_digits,
      expires_on: 1.year.from_now
    )
  end

  def nets_payment
    @nets_payment ||= Nets::QueryPayment.new(nets_payment_id).call
  end

  def send_subscription_activation_email
    SendSubscriptionActivationEmail.new(player, subscription).call
  end

  def schedule_cancelling_subscription
    CancelExpiredSubscriptionJob.set(
      wait_until: subscription.expires_on.end_of_day
    ).perform_later(subscription)
  end

  def schedule_expiration_reminder
    SendSubscriptionExpirationEmailJob.set(wait_until: week_before_expiration).
      perform_later(subscription)
  end

  def week_before_expiration
    (subscription.expires_on - 1.week).to_datetime
  end
end
