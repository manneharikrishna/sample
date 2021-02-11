class BankAccountNumberValidator < AbstractFormatValidator
  FORMAT = {
    NO: /\A\d{11}\z/,
    SE: /\A\d{20}\z/
  }.freeze

  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless value.match(FORMAT[COUNTRY_CODE.to_sym])
      record.errors.add(attribute, :invalid)
    end
  end
end
