class AbstractFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? && options[:allow_nil]

    unless value =~ self.class::FORMAT
      message = options[:message] || :invalid
      record.errors.add(attribute, message)
    end
  end
end
