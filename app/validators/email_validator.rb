class EmailValidator < ActiveModel::EachValidator
  FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, _, value)
    return if value.nil? && options[:allow_nil]

    unless value =~ FORMAT
      message = options[:message] || :invalid
      record.errors.add(:email, message)
    end
  end
end
