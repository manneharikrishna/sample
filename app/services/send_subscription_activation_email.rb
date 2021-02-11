class SendSubscriptionActivationEmail
  delegate :tickets_count, to: :@subscription
  def initialize(player, subscription)
    @player = player
    @subscription = subscription
  end

  def call
    SubscriptionMailer.activation(player, amount, tickets_count).deliver_later
  end

  private

  attr_reader :player
  attr_reader :subscription

  def amount
    (tickets_count * drawing.lottery.ticket_price).to_i
  end

  def drawing
    DrawingsQuery.new.call.last || Drawing.last
  end
end
