class RegisterPlayerInAccounting
  def initialize(player)
    @player = player
  end

  def call
    player.update!(twenty_four_seven_office_id: twenty_four_seven_office_id)
  end

  private

  attr_reader :player

  def twenty_four_seven_office_id
    TwentyFourSevenOffice::SaveCompany.new(company).call
  end

  def company
    TwentyFourSevenOffice::Company.new(player)
  end
end
