class StartDrawingJob < ApplicationJob
  def perform(drawing)
    return if drawing.status == :cancelled
    StartDrawing.new(drawing).call
  end
end
