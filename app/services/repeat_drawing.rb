class RepeatDrawing
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    drawing = create_drawing(lottery)
    schedule_drawing_preparation(drawing)
  end

  private

  attr_reader :lottery

  def create_drawing(lottery)
    CreateDrawing.new(lottery).call
  end

  def schedule_drawing_preparation(drawing)
    PrepareDrawingJob.perform_later(drawing)
  end
end
