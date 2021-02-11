class WithdrawalForm < AbstractForm
  include Reform::Form::Coercion

  property :amount, type: Types::Form::Decimal

  validates :amount, presence: true, numericality: { greater_than: 0 }

  def initialize(player)
    super()
    @player = player
  end

  def save
    @model = CreateWithdrawal.new(@player, amount).call
  end
end
