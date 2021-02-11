Admin::LotteryPolicy = Struct.new(:operator, :lottery) do
  def update?
    lottery_pending?
  end

  def destroy?
    lottery_pending?
  end

  private

  def lottery_pending?
    lottery.status == :pending
  end
end
