class SuspensionForm < Reform::Form
  include Reform::Form::Coercion

  property :suspended_until, type: Types::Form::DateTime

  validates :suspended_until, timeliness: { after: :now }

  def save
    SuspendPlayer.new(model, suspended_until).call
  end
end
