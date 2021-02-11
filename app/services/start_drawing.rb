class StartDrawing
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    update_drawing_status
    schedule_drawing_end
    subscribe_drawing
  end

  private

  attr_reader :drawing

  def update_drawing_status
    drawing.state_machine.transition_to!(:started)
  end

  def schedule_drawing_end
    EndDrawingJob.set(wait_until: drawing.ends_at).perform_later(drawing)
  end

  def subscribe_drawing
    active_subscriptions.each do |subscription|
      SubscribeDrawingJob.perform_later(subscription, drawing)
    end
  end

  def active_subscriptions
    @active_subscriptions ||= Subscription.active
  end
end
