class LicenseLimitationValidator < ActiveModel::EachValidator
  OPERATORS = { min: :<, max: :> }.freeze
  MESSAGES = { min: :cannot_fall_below, max: :cannot_exceed }.freeze

  def validate_each(record, attribute, value)
    return if value.nil?

    limitations.each do |limitation|
      limit = record.license["#{limitation}_#{attribute}"]

      if limit && value.send(OPERATORS[limitation], limit)
        record.errors.add(attribute, MESSAGES[limitation], count: limit)
      end
    end
  end

  private

  def limitations
    Array(options[:with] || options[:in]).map(&:to_sym)
  end
end
