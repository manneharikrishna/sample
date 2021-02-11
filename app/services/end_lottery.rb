class EndLottery
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    update_lottery_status
  end

  private

  attr_reader :lottery

  def update_lottery_status
    lottery.state_machine.transition_to!(:ended)
  end
end
