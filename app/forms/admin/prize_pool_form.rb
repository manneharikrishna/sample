class Admin::PrizePoolForm < Reform::Form
  include Reform::Form::Coercion

  delegate :license, to: :model

  property :tickets_count, type: Types::Form::Int
  property :ticket_price, type: Types::Form::Decimal

  validates :tickets_count, numericality: { only_integer: true,
    greater_than: 0 }, license_limitation: :max
  validates :ticket_price, numericality: { greater_than: 0 }
  validates :total_revenue, license_limitation: :max

  def total_revenue
    return unless ticket_price && tickets_count
    ticket_price * tickets_count
  end
end
