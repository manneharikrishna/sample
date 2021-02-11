class CreateWinning::PoolStrategy
  def initialize(drawing, _ticket)
    @drawing = drawing
  end

  def call
    @drawing.tickets.random
  end
end
