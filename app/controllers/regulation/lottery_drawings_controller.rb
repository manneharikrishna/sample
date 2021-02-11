class Regulation::LotteryDrawingsController < Regulation::BaseController
  def index
    drawings = lottery.drawings.order(ends_at: :desc)
    render json: drawings
  end

  private

  def lottery
    @lottery ||= Lottery.find(params[:lottery_id])
  end
end
