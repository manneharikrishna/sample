class CancelDrawing
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    drawing.state_machine.transition_to!(:cancelled)
  end

  private

  attr_reader :drawing
end
