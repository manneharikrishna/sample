class CancelLottery
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    lottery.transaction do
      cancel_drawings
      lottery.state_machine.transition_to!(:cancelled)
    end
  end

  private

  attr_reader :lottery

  def cancel_drawings
    lottery_drawings.each do |drawing|
      CancelDrawing.new(drawing).call
    end
  end

  def lottery_drawings
    lottery.drawings.in_state([:ready, :started])
  end
end
