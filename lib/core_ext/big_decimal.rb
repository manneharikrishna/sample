require 'active_support/core_ext/big_decimal'

module BigDecimalWithTwoDecimalPlaces
  def to_s(format = nil)
    return super if format || infinite?
    format('%.2f', self)
  end
end

BigDecimal.prepend(BigDecimalWithTwoDecimalPlaces)
