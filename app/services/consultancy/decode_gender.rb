class Consultancy::DecodeGender
  def initialize(player)
    @player = player
  end

  def call
    decode_gender
  end

  private

  attr_reader :player

  def decode_gender
    ssn_to_single_digits[-3].odd? ? 'male' : 'female'
  end

  def ssn_to_single_digits
    player.ssn.to_s.split('').map(&:to_i)
  end
end
