class PrepareLottery
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    drawing = create_drawing

    lottery.transaction do
      schedule_drawing_preparation(drawing)
      schedule_lottery_start
      update_lottery_status
    end
  end

  private

  attr_reader :lottery

  def create_drawing
    CreateDrawing.new(lottery).call
  end

  def schedule_drawing_preparation(drawing)
    PrepareDrawingJob.perform_later(drawing)
  end

  def schedule_lottery_start
    StartLotteryJob.set(wait_until: lottery.starts_at).perform_later(lottery)
  end

  def update_lottery_status
    lottery.state_machine.transition_to!(:ready)
  end
end
