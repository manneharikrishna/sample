class Admin::DrawingsController < Admin::BaseController
  def show
    render json: drawing
  end

  private

  def lottery
    @lottery ||= Lottery.find(params[:lottery_id])
  end

  def drawing
    @drawing ||= Drawing.find(params[:id])
  end
end
