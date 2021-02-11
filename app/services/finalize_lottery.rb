class FinalizeLottery
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    update_lottery_status
    schedule_lottery_preparation
  end

  private

  attr_reader :lottery

  def update_lottery_status
    lottery.state_machine.transition_to!(:final)
  end

  def schedule_lottery_preparation
    PrepareLotteryJob.perform_later(lottery)
  end
end
