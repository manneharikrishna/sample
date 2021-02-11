class Regulation::LotteriesController < Regulation::BaseController
  def index
    render json: lotteries.includes(include), include: include
  end

  def show
    render json: lottery
  end

  private

  def lotteries
    @lotteries ||= Regulation::LotteriesQuery.new.call
  end

  def lottery
    @lottery ||= lotteries.find(params[:id])
  end

  def include
    [:license, :transitions]
  end
end
