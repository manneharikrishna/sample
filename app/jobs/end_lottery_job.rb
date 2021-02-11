class EndLotteryJob < ApplicationJob
  def perform(lottery)
    EndLottery.new(lottery).call
  end
end
