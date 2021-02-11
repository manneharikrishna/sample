class LossLimitValidator < ActiveModel::Validations::NumericalityValidator
  def initialize(options)
    super({
      attributes: options[:attributes],
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: default_loss_limit(options)
    })
  end

  private

  def default_loss_limit(options)
    attribute = options[:attributes][0]
    Limits.send(attribute)
  end
end
