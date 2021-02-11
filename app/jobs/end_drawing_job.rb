class EndDrawingJob < ApplicationJob
  def perform(drawing)
    return if drawing.status == :cancelled
    EndDrawing.new(drawing).call
  end
end
