class PrepareDrawingJob < ApplicationJob
  def perform(drawing)
    PrepareDrawing.new(drawing).call
  end
end
