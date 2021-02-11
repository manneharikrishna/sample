class StartLotteryJob < ApplicationJob
  def perform(lottery)
    return unless lottery.status == :ready
    StartLottery.new(lottery).call
  end
end
