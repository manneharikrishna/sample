class CalculateBalance
  def initialize(player)
    @player = player
  end

  def call
    player.transactions.completed.sum(&:amount)
  end

  private

  attr_reader :player
end
