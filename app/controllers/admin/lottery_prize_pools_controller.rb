class Admin::LotteryPrizePoolsController < Admin::BaseController
  before_action :authorize_prize_pool

  def update
    submit_form(prize_pool_form, :ok)
  end

  private

  def authorize_prize_pool
    authorize(lottery, [:admin, :prize_pool])
  end

  def lottery
    @lottery ||= Lottery.find(params[:lottery_id])
  end

  def prize_pool_form
    PrizePoolFormFactory.new(lottery).create
  end
end
