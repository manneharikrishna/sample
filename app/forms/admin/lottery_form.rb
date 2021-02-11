class Admin::LotteryForm < Reform::Form
  include Reform::Form::Coercion

  delegate :license, to: :model

  property :name
  property :headline
  property :description
  property :starts_at, type: Types::Form::DateTime
  property :ends_at, type: Types::Form::DateTime
  property :cover
  property :repeat_every

  property :final, virtual: true, type: Types::Form::Bool

  validates :name, presence: true
  validates :headline, length: { maximum: 100 }
  validates :starts_at, timeliness: { after: :now }
  validates :ends_at, timeliness: { after: :starts_at }
  validates :repeat_every, presence: true,
    numericality: { only_integer: true, greater_than: 0 }, lottery_duration: true
  validates :duration, license_limitation: [:min, :max]

  def duration
    return unless repeat_every.present?
    repeat_every.to_d / 1.day
  end

  def save
    model.transaction do
      remove_cover if cover == ''
      finalize_lottery if super && final
    end
  end

  private

  def finalize_lottery
    FinalizeLottery.new(model).call
  end

  def remove_cover
    model.remove_cover!
  end
end
