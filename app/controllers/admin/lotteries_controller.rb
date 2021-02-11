class Admin::LotteriesController < Admin::BaseController
  before_action :authorize_lottery, only: [:update, :destroy]

  def index
    lotteries = LotteriesQuery.new.call
    render json: lotteries.includes(include), include: include
  end

  def create
    lottery = license.lotteries.build
    submit_form(Admin::NewLotteryForm.new(lottery))
  end

  def show
    render json: lottery
  end

  def update
    submit_form(Admin::LotteryForm.new(lottery), :ok)
  end

  def destroy
    lottery.destroy!
    head :ok
  end

  private

  def authorize_lottery
    authorize(lottery, [:admin, :lottery])
  end

  def lottery
    @lottery ||= Lottery.find(params[:id])
  end

  def license
    @license ||= License.find(params[:license_id])
  end

  def include
    [:license, :transitions]
  end
end
