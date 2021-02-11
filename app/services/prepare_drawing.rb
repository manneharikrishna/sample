class PrepareDrawing
  include StrategyHelper

  def initialize(drawing)
    @drawing = drawing
  end

  def call
    drawing.transaction do
      strategy.call
      update_drawing_status
      schedule_drawing_start
      schedule_prize_reveal
    end
  end

  private

  attr_reader :drawing

  def update_drawing_status
    drawing.state_machine.transition_to!(:ready)
  end

  def schedule_drawing_start
    StartDrawingJob.set(wait_until: drawing.starts_at).perform_later(drawing)
  end

  def schedule_prize_reveal
    reveal_time = drawing.ends_at + 24.hours
    RevealPrizesJob.set(wait_until: reveal_time).perform_later(drawing)
  end
end
