class PercentageValidator < ActiveModel::Validations::NumericalityValidator
  DEFAULT_OPTIONS = {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }.freeze

  def initialize(options)
    super(DEFAULT_OPTIONS.merge(options))
  end
end
