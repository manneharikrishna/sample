class CreateSubscriptionEntry
  delegate :player, to: :@subscription

  def initialize(subscription, deposit, drawing)
    @subscription = subscription
    @deposit = deposit
    @drawing = drawing
  end

  def call
    if subscription.active? && deposit_not_used?
      entry = create_subscription_entry
      assign_entry_to_deposit(entry)
    end
  end

  private

  attr_reader :subscription
  attr_reader :deposit
  attr_reader :drawing

  def deposit_not_used?
    deposit.entry.nil? && deposit.completed?
  end

  def create_subscription_entry
    CreateEntry.new(drawing, player, entry_params).call
  end

  def entry_params
    {
      tickets_count: subscription.tickets_count,
      photo_id: subscription.photo_id,
      entry_type: 'subscription'
    }
  end

  def assign_entry_to_deposit(entry)
    deposit.update!(entry_id: entry.id)
  end
end
