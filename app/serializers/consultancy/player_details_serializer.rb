class Consultancy::PlayerDetailsSerializer < PlayerSerializer
  attribute :id
  attribute :age
  attribute :gender
  attribute :balance

  def age
    Consultancy::CalculateAge.new(object).call
  end

  def gender
    Consultancy::DecodeGender.new(object).call
  end

  def balance
    CalculateBalance.new(object).call
  end
end
