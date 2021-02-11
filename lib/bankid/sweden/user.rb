class BankID::Sweden::User < BankID::User
  def birthdate
    day = ssn[6..7]
    month = ssn[4..5]
    year = ssn[0..3]

    "#{day}.#{month}.#{year}"
  end

  def ssn
    @data['se_ssn']
  end
end
