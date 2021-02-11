class VerifySubscription
  def initialize(subscription, deposit, drawing)
    @subscription = subscription
    @deposit = deposit
    @drawing = drawing
  end

  def call
    if drawing.status == :started
      verify_deposit
      activate_subscription
      create_subscription_entry
    end
  end

  private

  attr_reader :subscription
  attr_reader :deposit
  attr_reader :drawing

  def activate_subscription
    ActivateSubscription.new(subscription, deposit).call
  end

  def verify_deposit
    Deposits::Verify.new(deposit).call
  end

  def create_subscription_entry
    CreateSubscriptionEntry.new(subscription, deposit, drawing).call
  end
end
