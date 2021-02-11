class CalculateDrawingEnd
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    lottery_start + lottery_drawings_duration
  end

  private

  attr_reader :lottery

  def lottery_start
    lottery.starts_at
  end

  def lottery_drawings_duration
    lottery.repeat_every.seconds * (lottery.drawings.count + 1)
  end
end
