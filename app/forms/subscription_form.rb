class SubscriptionForm < Reform::Form
  include Reform::Form::Coercion

  property :tickets_count, type: Types::Form::Int
  property :photo_id, virtual: true
  property :drawing_id, virtual: true
  property :redirect_url
  property :amount, virtual: true, type: Types::Form::Decimal

  validates :tickets_count, presence: true, numericality: { only_integer: true,
    greater_than: 0 }
  validates :photo_id, presence: true
  validates :drawing_id, presence: true
  validates :redirect_url, presence: true, url: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def initialize(player)
    super(Subscription.new)
    @player = player
  end

  def save
    @model = CreateSubscription.new(@player, params).call
  end

  private

  def params
    @fields.with_indifferent_access
  end
end
