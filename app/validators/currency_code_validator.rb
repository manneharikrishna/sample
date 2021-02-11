class CurrencyCodeValidator < ActiveModel::EachValidator
  CURRENCY_CODES = ISO4217::Currency.currencies.keys

  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless CURRENCY_CODES.include?(value)
      record.errors.add(attribute, :invalid)
    end
  end
end
