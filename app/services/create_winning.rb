class CreateWinning
  include StrategyHelper

  def initialize(drawing, ticket = nil)
    @drawing = drawing
    @ticket = ticket
  end

  def call
    drawing.winnings.create! do |winning|
      winning.ticket = strategy.call
    end
  end

  private

  attr_reader :drawing
  attr_reader :ticket

  def strategy
    strategy_class.new(drawing, ticket)
  end
end
