class Admin::PredrawnPrizePoolForm < Admin::PrizePoolForm
  REVEAL_TYPES = Prize::REVEAL_TYPES.map(&:to_s).freeze

  validates :prizes, presence: true

  collection :prizes, populator: PrizePopulator do
    include Reform::Form::Coercion

    property :name
    property :description
    property :value, type: Types::Form::Decimal
    property :quantity, type: Types::Form::Int
    property :reveal_type
    property :image

    validates :name, presence: true
    validates :value, numericality: { greater_than: 0 }
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
    validates :reveal_type, inclusion: REVEAL_TYPES

    def total_value
      value * quantity if value && quantity
    end
  end

  validates_with PrizesQuantityValidator
  validates_with PrizesTotalValueValidator

  validates :payback_ratio, license_limitation: [:min, :max]

  def payback_ratio
    CalculatePaybackRatio.new(self).call
  end
end
