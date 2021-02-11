class Admin::PoolPrizePoolForm < Admin::PrizePoolForm
  property :payback_ratio, type: Types::Form::Int

  validates :payback_ratio, percentage: { greater_than: 0 },
    license_limitation: [:min, :max]
end
