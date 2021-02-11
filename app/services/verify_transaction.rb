class VerifyTransaction
  def initialize(deposit)
    @deposit = deposit
  end

  def call
    verify_deposit if subscription.nil?
    verify_subscription_deposit if subscription.present?
  end

  private

  attr_reader :deposit
  attr_reader :subscription

  def subscription
    @subscription ||= deposit.subscription
  end

  def verify_deposit
    Deposits::Verify.new(deposit).call
  end

  def verify_subscription_deposit
    VerifySubscription.new(subscription, deposit, drawing).call
  end

  def drawing
    DrawingsQuery.new.call.last
  end
end
