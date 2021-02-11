class SubscribeDrawingJob < ApplicationJob
  def perform(subscription, drawing)
    return unless drawing.status == :started && subscription.active?
    SubscribeDrawing.new(subscription, drawing).call
  end
end
