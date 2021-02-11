module CurrencyHelper
  include ActionView::Helpers::NumberHelper

  def amount_with_currency(value)
    number_to_currency(value, unit: currency_unit)
  end

  def currency_unit
    I18n.t(CURRENCY, scope: 'currency.unit', default: CURRENCY)
  end
end
