class Regulation::LotteryCancellationsController < Regulation::BaseController
  before_action :authorize_cancellation

  def create
    CancelLottery.new(lottery).call
    render json: lottery, status: :created
  end

  private

  def authorize_cancellation
    authorize(lottery, [:regulation, :lottery_cancellation])
  end

  def lottery
    @drawing ||= Lottery.find(params[:lottery_id])
  end
end
