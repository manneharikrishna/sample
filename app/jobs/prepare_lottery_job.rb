class PrepareLotteryJob < ApplicationJob
  def perform(lottery)
    PrepareLottery.new(lottery).call
  end
end
