class Regulation::LicenseForm < Reform::Form
  include Reform::Form::Coercion

  property :name
  property :min_duration, type: Types::Form::Int
  property :max_duration, type: Types::Form::Int
  property :max_tickets_count, type: Types::Form::Int
  property :max_total_revenue, type: Types::Form::Decimal
  property :min_payback_ratio, type: Types::Form::Int
  property :max_payback_ratio, type: Types::Form::Int

  validates :name, presence: true

  validates_uniqueness_of :name

  with_options(allow_nil: true) do
    validates :min_duration, numericality: { only_integer: true, greater_than: 0 }
    validates :max_duration, numericality: { only_integer: true, greater_than: 0 }
    validates :max_tickets_count, numericality: { only_integer: true, greater_than: 0 }
    validates :max_total_revenue, numericality: { greater_than: 0 }
    validates :min_payback_ratio, percentage: { only_integer: true, greater_than: 0 }
    validates :max_payback_ratio, percentage: { only_integer: true, greater_than: 0 }
  end
end
