class StartLottery
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    update_lottery_status
    schedule_lottery_end
  end

  private

  attr_reader :lottery

  def update_lottery_status
    lottery.state_machine.transition_to!(:started)
  end

  def schedule_lottery_end
    EndLotteryJob.set(wait_until: lottery.ends_at).perform_later(lottery)
  end
end
