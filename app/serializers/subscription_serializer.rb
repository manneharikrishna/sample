class SubscriptionSerializer < ActiveModel::Serializer
  attribute :id
  attribute :amount
  attribute :tickets_count
  attribute :photo_id
  attribute :status
  attribute :payment_method
  attribute :card_last_digits
  attribute :card_expiration_date
  attribute :redirect_url
  attribute :expires_on

  has_one :deposit

  def amount
    object.tickets_count * drawing.lottery.ticket_price
  end

  def deposit
    Deposit.find_by(subscription_id: object.id)
  end

  class DepositSerializer < ActiveModel::Serializer
    attribute :id
    attribute :status
  end

  private

  def drawing
    @drawing ||= DrawingsQuery.new.call.last || Drawing.last
  end
end
