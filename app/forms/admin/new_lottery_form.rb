class Admin::NewLotteryForm < Reform::Form
  include Reform::Form::Coercion

  delegate :license, to: :model

  property :name

  validates :license, presence: true
  validates :name, presence: true
end
