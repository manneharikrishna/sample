class BankAccountOwnershipValidator < AbstractFormatValidator
  def validate_each(record, attribute, value)
    ssn = record.model.ssn

    return if value.blank? && options[:allow_blank] || ssn.nil?

    unless bank_account_owner?(ssn, value)
      record.errors.add(attribute, :not_owned)
    end
  end

  private

  def bank_account_owner?(ssn, bank_account_number)
    KAR::Client.new(ssn, bank_account_number).call
  end
end
