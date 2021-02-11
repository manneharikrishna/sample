class BankID::User
  def initialize(data)
    @data = data
  end

  def given_name
    @data['given_name']
  end

  def family_name
    @data['family_name']
  end

  def phone_number
    @data['phone_number']
  end

  def birthdate
    @data['birthdate']
  end
end
