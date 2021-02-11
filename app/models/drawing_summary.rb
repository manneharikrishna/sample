class DrawingSummary
  include ActiveModel::Serialization

  delegate :count, prefix: 'weekly_tickets', to: :weekly_tickets
  delegate :count, prefix: 'subscription_tickets', to: :subscription_tickets

  def initialize(player, drawing)
    @player = player
    @drawing = drawing
  end

  def drawing_revenue
    subscription_tickets_value.to_i + weekly_tickets_value.to_i
  end

  private

  def autorevealed_tickets
    @autorevealed_tickets ||= AutorevealedTicketsQuery.new(@player, @drawing)
  end

  def weekly_tickets
    autorevealed_tickets.weekly_tickets
  end

  def subscription_tickets
    autorevealed_tickets.subscription_tickets
  end

  def subscription_tickets_value
    subscription_prizes = subscription_tickets.map(&:prize).compact

    subscription_prizes.map { |p| p if p.reveal_type == 'instant' }.compact.sum(&:value)
  end

  def weekly_tickets_value
    weekly_prizes = weekly_tickets.map(&:prize).compact

    weekly_prizes.map { |prize| prize }.compact.sum(&:value)
  end
end
