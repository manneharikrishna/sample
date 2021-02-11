class Consultancy::CalculateAge
  def initialize(player)
    @player = player
  end

  def call
    calculate_age
  end

  private

  attr_reader :player

  def calculate_age
    ((Time.zone.today - player.birthdate) / 365).floor
  end
end
