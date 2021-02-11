class BankID::Norway::User < BankID::User
  def ssn
    @data['no_ssn']
  end
end
