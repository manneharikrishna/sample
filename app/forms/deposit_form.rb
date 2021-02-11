class DepositForm < Reform::Form
  include Reform::Form::Coercion

  property :amount, type: Types::Form::Decimal
  property :redirect_url

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :redirect_url, presence: true, url: true

  def initialize(player)
    super(Deposit.new)
    @player = player
  end

  def save
    @model = Deposits::Create.new(@player, payload).call
  end

  private

  def payload
    params = @fields.with_indifferent_access
    Deposits::ConfigurePayload.new(@player, params)
  end
end
