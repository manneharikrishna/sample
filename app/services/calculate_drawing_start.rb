class CalculateDrawingStart
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    last_drawing&.ends_at || lottery.starts_at
  end

  private

  attr_reader :lottery

  def last_drawing
    lottery.drawings.order(ends_at: :asc).last
  end
end
