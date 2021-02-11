class LossLimitsForm < Reform::Form
  include Reform::Form::Coercion

  property :weekly_loss_limit, type: Types::Form::Int
  property :daily_loss_limit, type: Types::Form::Int

  validates :weekly_loss_limit, presence: true, loss_limit: true
  validates :daily_loss_limit, presence: true, loss_limit: true,
    numericality: { less_than_or_equal_to: :weekly_loss_limit }

  def weekly_loss_limit
    @fields['weekly_loss_limit'].to_i
  end
end
